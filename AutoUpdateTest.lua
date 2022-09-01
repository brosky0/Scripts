script_name = 'AutoUpdate'
script_autho = 'Jamelia / brosky'

require 'lib.moonloader'
local dlstatus = require('moonloader').download_status
local inicfg = require 'inicfg'
local imgui = require 'imgui'
local encoding = require 'encoding'

encoding.default = 'CP1251'
u8 = encoding.UTF8

update_state = false

local script_ver = 1
local script_vers_text = '1.00'

local script_path  = thisScript().path 
local script_url = 'https://raw.githubusercontent.com/brosky0/Scripts/main/AutoUpdateTest.lua'

local update_path = getWorkingDirectory() .. '//update.ini'
local update_url = 'https://raw.githubusercontent.com/brosky0/Scripts/main/update.ini'

function main()
    if not isSampLoaded() and not isSampfuncsLoaded() then return end 
    while not isSampAvailable() do wait(100) end
  
    sampRegisterChatCommand('update', cmd)

    downloadUrlToFile(update_url, update_path, function(id, stauts)
        if status == dlstatus.ENDDOWNLOADDATA then
            updateIni = inicfg.loag(nil, update_path)
            if tonumber(updateIni.info.vers) > script_ver then
                smapAddChatMessage('There is an update' .. updateIni.info.script_vers_text)
                update_state = true
            end
            os.remove(update_path)
        end
    end)

    while true do
        wait(0)
        
        if update_state then
            downloadUrlToFile(script_url, script_path, function(id, stauts)
                if status == dlstatus.ENDDOWNLOADDATA then
                    smapAddChatMessage('Script Updated', -1)
                    thisScript():reload()
                end
            end)
            break
        end
    end
end

function cmd(arg)
    sampShowDialog(1000, 'xd1', 'xd2', 'xd3', '', 0)
end
