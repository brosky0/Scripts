script_name = 'AutoUpdate'
script_author = 'Jamelia / brosky'

require 'lib.moonloader'
local dlstatus = require('moonloader').download_status
local inicfg = require 'inicfg'
local vkeys = require 'vkeys'
local imgui = require 'imgui'
local encoding = require 'encoding'

encoding.default = 'CP1251'
u8 = encoding.UTF8

update_state = false

local script_ver = 2
local script_ver_text = '2.00'

local script_path  = thisScript().path 
local script_url = 'https://raw.githubusercontent.com/brosky0/Scripts/main/AutoUpdateTest.lua'

local update_path = getWorkingDirectory() .. '//update.ini'
local update_url = 'https://raw.githubusercontent.com/brosky0/Scripts/main/update.ini'

function main()
    if not isSampLoaded() and not isSampfuncsLoaded() then return end 
    while not isSampAvailable() do wait(100) end
  
    sampRegisterChatCommand('update', cmd)

    downloadUrlToFile(update_url, update_path, function(id, status)
        if status == dlstatus.STATUS_ENDDOWNLOADDATA then
            updateIni = inicfg.load(nil, update_path)
            if tonumber(updateIni.info.ver) > script_ver then
                sampAddChatMessage('There is an update' .. updateIni.info.ver_text, -1)
                update_state = true
            end
            os.remove(update_path)
        end
    end)
    


    while true do
        wait(0)
        
        if update_state then
            downloadUrlToFile(script_url, script_path, function(id, status)
                if status == dlstatus.STATUS_ENDDOWNLOADDATA then
                    sampAddChatMessage('Script Updated', -1)
                    thisScript():reload()
                end
            end)
            break
        end
    end
end

function cmd(arg)
    sampShowDialog(1000, '', 'AutoUpdate Checker', 'Close', '', 0)
end
