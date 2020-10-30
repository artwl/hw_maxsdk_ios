#!/usr/bin/env ruby
# ----------------------------------------------------------------------------------------------------------------------------------------------------------
#  AppLovin Quality Service Setup Script for iOS
#  (c) 2020 AppLovin. All Rights Reserved
#
#  Syntax:
#    ruby AppLovinQualityServiceSetup-xyz.rb <command> <options>
#
#  Commands:
#    install - installs AppLovinQualityService onto an iOS target
#    uninstall - uninstalls AppLovinQualityService from a target
#    update - updates the AppLovinQualityService pod to the latest version, or to specific version if version number follows
#
#  Options:
#    -targetid <target id> - installs on a specific target identified by its ID as appears in the xcodeproj file (applicable to "install" and "uninstall")
#    -targetname <target name> - installs on a specific target identified by its name (applicable to "install" and "uninstall")
#    -version <version> - installs a specific version and blocks automatic future updates (applicable to "install")
#
#  Examples:
#    ruby AppLovinQualityServiceSetup-xyz.rb  (when no parameters given, invokes the "install" command)
#    ruby AppLovinQualityServiceSetup-xyz.rb install -targetname MyTarget  (installs on target name "MyTarget")
#    ruby AppLovinQualityServiceSetup-xyz.rb uninstall
#    ruby AppLovinQualityServiceSetup-xyz.rb uninstall -targetname MyTarget
# ----------------------------------------------------------------------------------------------------------------------------------------------------------
require 'net/http'
require 'openssl'
require 'rexml/document'
require 'fileutils'
require 'date'
require 'digest'

# Developer-specific ID
application_data=<<APPLICATION_DATA
{
  "api_key": "9429839ba6efb4a1ba8249f1564cc68d208640d511655684860aa15ff61caa323207d9c15039e9a71188c8"
}
APPLICATION_DATA


# Internal
class String
  def escape
    self.force_encoding("UTF-8").gsub(/[\\\"`$]/){|m| '\\' + m }
  end
  def description
      self.sub(".pre.","-")
  end
end

MAVEN_REPO = "Quality-Service"
MAVEN_USER = nil
MAVEN_PASSWORD = nil


MAVEN_SERVER = "applovin.bintray.com"
MAVEN_GROUP = "com/applovin/quality"
MAVEN_GROUP_ID = "com.applovin.quality"
MAVEN_ARTIFACT_ID = "AppLovinQualityServicePod"
MAVEN_ARTIFACT_TYPE = "zip"

SERVICE_NAME = "AppLovinQualityService"
HOME_PATH = File.expand_path('~')
POD_REPO_PATH = "#{HOME_PATH}/.#{SERVICE_NAME}/iOSPodsRepo"
SCRIPT_PATH = File.expand_path(__FILE__)
SCRIPT_DIR = File.dirname(SCRIPT_PATH)
APPLOVIN_QUALITY_SERVICE_DIR = SERVICE_NAME
APPLOVIN_QUALITY_SERVICE_PATH = "#{SCRIPT_DIR}/#{APPLOVIN_QUALITY_SERVICE_DIR}"
SCRIPT_NAME = File.basename($0).escape

LAST_UPDATE_FILE = "last_update.txt"
LAST_UPDATE_PATH = "#{POD_REPO_PATH}/#{LAST_UPDATE_FILE}"
LAST_USED_FILE = "last_used.txt"
INSTALLER_APP = "#{SERVICE_NAME}Installer.app"
PLUGIN_APP = "#{SERVICE_NAME}Plugin.app"
SETUP_SCRIPT = "#{SERVICE_NAME}Setup.rb"
CLIENT_FRAMEWORK = "#{SERVICE_NAME}.framework"
LICENSE_FILE = "APPLOVIN-LICENSE.txt"
LICENSES_DIR = "Third-Party-Licenses"
CHECK_INTERVAL = 24*3600
CLEANUP_INTERVAL = 90*24*3600

COMPONENTS = [CLIENT_FRAMEWORK, INSTALLER_APP, PLUGIN_APP, SETUP_SCRIPT, LAST_UPDATE_FILE, LICENSE_FILE, LICENSES_DIR, '.gitignore']

@version = '4.4.4'

@last_update = Time.at(0)
@specific_version = nil
@target_id = nil
@target_name = nil

CMD_INSTALL = "install"
CMD_UNINSTALL = "uninstall"
CMD_UPDATE = "update"

SUPPORT_EMAIL = "devsupport@applovin.com"


def init_and_cleanup
  FileUtils.mkdir_p POD_REPO_PATH
  FileUtils.mkdir_p APPLOVIN_QUALITY_SERVICE_PATH
  COMPONENTS.each do |component|
    path = "#{APPLOVIN_QUALITY_SERVICE_PATH}/#{component}"
    FileUtils.rm_rf(path) if File.exist?(path)
  end

  dirs = Dir.entries(POD_REPO_PATH).select{|f| f != '.' && f != '..' && File.directory?(File.join(POD_REPO_PATH, f)) }
  @local_versions = dirs.map{|dir| Gem::Version.new(dir) rescue nil}.compact
  @highest_local_version = @local_versions.max

  dirs.each do |dir|
    path = "#{POD_REPO_PATH}/#{dir}"
    last_used_path = "#{path}/#{LAST_USED_FILE}"
    content = File.read(last_used_path) rescue nil
    next unless content
    last_used = DateTime.iso8601(content.strip).to_time
    FileUtils.rm_rf(path) if (Time.now - last_used) > CLEANUP_INTERVAL
  end
end


def confirm_xcode_projects_exist
  project_paths = Dir.glob("#{SCRIPT_DIR}/*.xcodeproj")
  raise "Could not find Xcode project file(s) under #{SCRIPT_DIR}\nPlease copy this script to your Xcode project directory and run it from there." unless project_paths.count > 0
  project_paths
end


def read_last_update
  content = File.read(LAST_UPDATE_PATH) rescue nil
  return nil unless content
  @last_update = DateTime.iso8601(content.strip).to_time
rescue
  # ignore
end


def update_last_update_file
  File.open(LAST_UPDATE_PATH, 'w') { |file| file.write(DateTime.now.to_s) } rescue nil
end


def update_last_used(pod_zip)
  last_used_path = "#{File.dirname(pod_zip)}/#{LAST_USED_FILE}"
  File.open(last_used_path, 'w') { |file| file.write(DateTime.now.to_s) } rescue nil
end


def fetch(uri_str, limit=10)
  raise 'Too many HTTP redirects' if limit == 0
  uri = URI(uri_str)
  Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https', :verify_mode => OpenSSL::SSL::VERIFY_NONE, :open_timeout => 30) do |http|
    request = Net::HTTP::Get.new uri.request_uri
    request.basic_auth MAVEN_USER, MAVEN_PASSWORD unless MAVEN_USER.nil?
    resp = http.request(request)
    case resp
    when Net::HTTPSuccess
      resp.body
    when Net::HTTPRedirection
      location = resp['location']
      fetch(location, limit - 1)
    else
      raise "Server response code: #{resp.code}"
    end
  end
rescue Exception => e
  raise "Failed to access AppLovin Maven repository: #{e.message}"
end


def get_latest_remote_version
  begin
    uri = URI("https://#{MAVEN_SERVER}/#{MAVEN_REPO}/#{MAVEN_GROUP}/#{MAVEN_ARTIFACT_ID}/maven-metadata.xml")
    maven_data = fetch(uri)
  rescue Exception => e
    raise "Failed to access AppLovin Maven repository: #{e.message}"
  end

  begin
    doc = REXML::Document.new maven_data
    group_id = doc.root.elements["groupId"].text
    artifact_id = doc.root.elements["artifactId"].text
    version = doc.root.elements["versioning/release"].text
  rescue
    raise "Failed to parse maven metadata received from server"
  end

  # Some basic validation
  if group_id != MAVEN_GROUP_ID || artifact_id != MAVEN_ARTIFACT_ID
    raise "Failed to properly parse Maven metadata"
  end

  Gem::Version.new(version) rescue Gem::Version.new('0')

rescue Exception => e
  puts e.message
  nil
end


def download_pod(version)
  pod_zip = "#{POD_REPO_PATH}/#{version}/#{MAVEN_ARTIFACT_ID}-#{version}.zip"

  puts "Downloading #{SERVICE_NAME} Pod version #{version}..."
  uri = URI("https://#{MAVEN_SERVER}/#{MAVEN_REPO}/#{MAVEN_GROUP}/#{MAVEN_ARTIFACT_ID}/#{version}/#{MAVEN_ARTIFACT_ID}-#{version}.#{MAVEN_ARTIFACT_TYPE}")
  content = fetch(uri)

  puts "Validating #{SERVICE_NAME} Pod checksum..."
  uri = URI("https://#{MAVEN_SERVER}/#{MAVEN_REPO}/#{MAVEN_GROUP}/#{MAVEN_ARTIFACT_ID}/#{version}/#{MAVEN_ARTIFACT_ID}-#{version}.#{MAVEN_ARTIFACT_TYPE}.md5")
  md5 = fetch(uri)
  raise "Failed to validate Pod MD5 checksum" unless Digest::MD5.hexdigest(content) == md5

  FileUtils.mkdir_p "#{POD_REPO_PATH}/#{version}"
  open(pod_zip, "wb") do |file|
    file.write(content)
  end

  pod_zip
end


def get_pod_zip
  pod_zip = nil
  version = nil
  if @specific_version
    version = @specific_version.to_s.description
  else
    if @highest_local_version && @command != CMD_INSTALL
      if (Time.now - @last_update) < CHECK_INTERVAL
        puts "#{SERVICE_NAME} Pod was updated within the last #{CHECK_INTERVAL.to_i / 3600} hours, no update required"
        version = @highest_local_version.to_s.description
      end
    end
  end
  return pod_zip if pod_zip && File.exist?(pod_zip)

  if version.nil?
    remote_version = get_latest_remote_version
    if remote_version
      puts "#{SERVICE_NAME} Pod has the latest version, no update required" if @highest_local_version == remote_version
      update_last_update_file
      version = remote_version.to_s.description
    else
      version = @highest_local_version.to_s.description rescue nil
    end
  end
  raise "#{SERVICE_NAME} Pod version could not be evaluated" if version.nil? || version == '0'

  pod_zip ||= "#{POD_REPO_PATH}/#{version}/#{MAVEN_ARTIFACT_ID}-#{version}.zip"
  return pod_zip if File.exist?(pod_zip)

  download_pod(version)
end


def update_setup_file
  return unless File.exist?("#{APPLOVIN_QUALITY_SERVICE_PATH}/#{SETUP_SCRIPT}")

  setup_content = File.read("#{APPLOVIN_QUALITY_SERVICE_PATH}/#{SETUP_SCRIPT}")
  app_setup_content = File.read(__FILE__)

  ["MAVEN_REPO","MAVEN_USER","MAVEN_PASSWORD"].each do |symbol|
    original_line = app_setup_content[/#{symbol}\s*=.*?$/]
    setup_content.gsub!(/#{symbol}\s*=.*?$/, original_line)
  end

  app_data_match = app_setup_content.scan(/(APPLICATION\_DATA.*APPLICATION\_DATA)/m)
  return if app_data_match.count == 0

  app_data = app_data_match.last.first
  setup_content.gsub!(/APPLICATION\_DATA.*APPLICATION\_DATA/m, app_data)
  File.write(__FILE__, setup_content)

rescue Exception => msg
  raise "Failed to update #{__FILE__} file, reason: #{msg}"
end


def inflate_pod(pod_zip)
  begin
    puts "Extracting Pod #{File.basename(pod_zip)} into #{APPLOVIN_QUALITY_SERVICE_DIR} directory..."
    is_ok = system("unzip -qq -o \"#{pod_zip}\" -d \"#{APPLOVIN_QUALITY_SERVICE_PATH}\"")
    raise "Failed to unzip the #{SERVICE_NAME} Pod" unless is_ok
  ensure
    update_last_used(pod_zip)
    update_setup_file
  end
end


def apply_pod
  additional_params = ""
  additional_params += " -targetid \"#{@target_id}\"" if @target_id
  additional_params += " -targetname \"#{@target_name}\"" if @target_name
  invocation = "\"#{APPLOVIN_QUALITY_SERVICE_PATH}/#{INSTALLER_APP}/Contents/MacOS/#{SERVICE_NAME}Installer\" #{@command} -projectdir \"#{SCRIPT_DIR}\" -setupfile \"#{SCRIPT_NAME}\" -nosig #{additional_params}"
  invocation += " -version \"#{@specific_version}\"" if @specific_version
  is_ok = system(invocation)
  raise "Failed to apply the #{SERVICE_NAME} Pod" unless is_ok
end


def read_arg(i)
  if i+1 < ARGV.count
    return ARGV[i+1], i+1
  else
    return nil, i
  end
end


def read_specific_version(ver)
  version = Gem::Version.new(ver)
  @specific_version = version.to_s.description
rescue
  raise("Illegal version number: #{ver}")
end


def read_command_line_options
  count = ARGV.count
  return unless count > 1
  i = 1
  while i < count
    case ARGV[i]
    when "-targetid"
      @target_id, i = read_arg(i)

    when "-targetname"
      @target_name, i = read_arg(i)

    when "-version"
      specific_version, i = read_arg(i)
      read_specific_version(specific_version)

    else
      raise "Unrecognized command line option #{ARGV[i]}"
    end
    i += 1
  end
end


def read_command_line_args
  @command = case ARGV[0]
             when nil
               CMD_INSTALL

             when CMD_INSTALL
               read_command_line_options
               CMD_INSTALL

             when CMD_UNINSTALL
               read_command_line_options
               CMD_UNINSTALL

             when CMD_UPDATE
               if ARGV[1]
                 if ARGV[1].start_with?('-')
                   read_command_line_options
                 else
                   read_specific_version(ARGV[1])
                 end
               end
               CMD_UPDATE

             else
               raise "Unrecognized command: #{ARGV[0]}\n" +
                         "Usage: ruby #{File.basename($0)} <command> <options>\n" +
                         "Where:\n" +
                         "  command - install | uninstall | update\n"
             end
end


def print_end_message
  if @command == CMD_INSTALL
    puts "If you decide to uninstall the #{SERVICE_NAME} Pod at any stage, you may run:"
    puts "ruby #{File.basename($0)} uninstall"
    puts "In case you encounter any issues, please contact us at #{SUPPORT_EMAIL}"
  elsif @command == CMD_UNINSTALL
    puts "If you uninstalled #{SERVICE_NAME} from all of your targets and projects and no longer need it,"
    puts "you may manually delete the #{APPLOVIN_QUALITY_SERVICE_DIR} directory under your project,"
    puts "as well as delete this #{File.basename($0)} script."
    puts "In case you encounter any issues, please contact us at #{SUPPORT_EMAIL}"
  end
end


begin
  STDOUT.sync = true
  puts "---------------------------------------------------------------------"
  puts " AppLovin Quality Service Xcode Setup Script #{"Version #{@version}" if @version}"
  puts " Copyright (c) 2020 AppLovin. All Rights Reserved."
  puts "---------------------------------------------------------------------"

  read_command_line_args
  init_and_cleanup

  read_last_update

  confirm_xcode_projects_exist unless @command == CMD_UPDATE

  pod_zip = get_pod_zip
  inflate_pod(pod_zip)

  unless @command == CMD_UPDATE
    puts
    apply_pod
    print_end_message
  end

  puts "..DONE"

rescue Exception => e
  abort("\n#{e.message}\n#{SERVICE_NAME} setup FAILED\n\n")
end
