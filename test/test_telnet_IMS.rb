#!/usr/bin/env ruby1.9.3

# подключение библиотеки тестирования
require "test/unit"

$:.unshift File.join(File.dirname(__FILE__), "..", "lib")

load 'commutation_system.rb'

class TestStation < Test::Unit::TestCase

  @@omu_core = CommutationSystem::IMS.new(
    host: '10.52.249.6',
    username: 'admin',
    password: 'lem')

  # Тестирование подключения к станции по telnet
  def test_01_telnet_connect
    assert @@omu_core.connection_telnet.connect
  end
  # Авторизации на станции по telnet
  def test_02_telnet_login
    assert @@omu_core.connection_telnet.login
  end
  # Отправка команды на станцию по telnet
  def test_03_telnet_command
    assert @@omu_core.connection_telnet.cmd('DSP TIME:;')
    assert @@omu_core.connection_telnet.answer
  end
  #Закрытие telnet соединения со станцией
  def test_04_telnet_close
    assert @@omu_core.connection_telnet.close
  end
end
