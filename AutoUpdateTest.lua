script_name = 'AutoUpdate'
script_autho = 'Jamelia / brosky'

require 'lib.moonloader'
local dlstatus = require('moonloader').download_status
local incfg = require 'inicfg'
local imgui = require 'imgui'

encoding.default = 'CP1251'
u8 = encoding.UTF*

local script_ver = 1 
local script_vers_text = '1'
local script_path  = thisScript().path 
local script_url = ''
local update_path = getWorkingDirectory() .. '//update.ini'
local update_url = ''

function main()
    if not isSampLoaded() and not isSampfuncsLoaded() then return end 
    while not isSampAvailable() do wait(100) end
  
    sampRegisterChatCommand('update', cmd)

    while true do
        wait(0)
    end
end

