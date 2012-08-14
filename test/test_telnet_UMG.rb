#!/usr/bin/env ruby1.9.3
# coding: utf-8

# подключение библиотеки тестирования
require "test/unit"

$:.unshift File.join(File.dirname(__FILE__), "..", "lib")

load 'commutation_system.rb'

class TestStation < Test::Unit::TestCase

  @@ats = CommutationSystem::UMG.new(
    host: '10.52.251.12',
    username: 'admin',
    password: 'BQVC4OY3pfy',
    log: true)

  # Тестирование подключения к станции по telnet
  def test_01_telnet_connect
    assert @@ats.connection_telnet.connect
  end
  # Авторизации на станции по telnet
  def test_02_telnet_login
    assert @@ats.connection_telnet.login
  end
  # Отправка команды на станцию по telnet
  def test_03_telnet_command
    assert @@ats.connection_telnet.cmd('DSP TIME:;')
    assert @@ats.connection_telnet.answer

  end
  #Закрытие telnet соединения со станцией
  def test_04_telnet_close
    assert @@ats.connection_telnet.close
  end
end
