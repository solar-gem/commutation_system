require "commutation_system/version"

# Реализация подключения к станции по telnet
require "commutation_system/connection_to_commutation_system_telnet"

# Реализация подключения к станции по протоколу soap
require "commutation_system/connection_to_commutation_system_soap"


module CommutationSystem
  class SubscriberIMS
    attr_accessor :sUBID
    attr_accessor :iMPI
    attr_accessor :iMPU_sip
    attr_accessor :iMPU_tel

    attr_accessor :hUSERNAME
    attr_accessor :pWD

    attr_accessor :iRSID
    attr_accessor :iMPULIST
    attr_accessor :bASEIMPU
    attr_accessor :aLIASID
    attr_accessor :sIFCID

    def initialize(tel, domain, password = nil)
      @sUBID = tel
      @iMPI = @hUSERNAME = "#{tel}@#{domain}"
      @iMPU_sip = "sip:#{tel}@#{domain}"
      @iMPU_tel = "tel:#{tel}"
      @pWD = password
      @iRSID = 1
      @iMPULIST = "\"#{@iMPU_sip}\"&\"#{@iMPU_tel}\""
      @bASEIMPU = @iMPU_sip
      @aLIASID = 1
      @sIFCID = 240
    end
  end





  class CommutationSystem
    # Параметры
    # type:     Тип станции. [:SoftX, :IMS, :UA5000, :Switch, :CC08, :NeaxE, :NeaxSigma]
    # host:     IP станции.
    # username: Имя прользователя.
    # password: Пароль.
    # log:      true || false Нужно ли вести log файл обмена данными со станцией.
    # log_path: Директория где будут храниться log файлы обмена данными со станцией
    # log_name: Название log файла обмена данными со станцией
    #

    attr_reader :connection_telnet # Создаём объект подключения к станции по протоколу telnet
    def initialize(options)
      verification # Проверка обязательных параметров


      # Анализ параметров касающихся log файлов обмена данными со станцией.
      unless @options.has_key?(:log)
        if @options.has_key?(:log_path) || @options.has_key?(:log_name)
          @options[:log] = true
        else
          @options[:log] = false
        end
      end
      @options[:log_path] = '.' unless @options.has_key?(:log_path)
      @options[:log_name] = "output_#{Time.now.strftime("%Y_%m_%d_%H_%M_%S")}.log" unless @options.has_key?(:log_name)


      # Создаём объект подключения к станции по протоколу telnet
      init_telnet
    end

    # Проверка обязательных параметров
    def verification
      # :type => тип станции
      raise ArgumentError.new("There is no option :type") unless @options.has_key?(:type)
      raise ArgumentError.new("There is no option :host") unless @options.has_key?(:host)
      raise ArgumentError.new("There is no option :username") unless @options.has_key?(:username)
      raise ArgumentError.new("There is no option :password") unless @options.has_key?(:password)
    end

    # Создаём объект подключения к станции по протоколу telnet
    def init_telnet
      case @options[:type]
      when :SoftX
        @connection_telnet =  ConnectionTelnet_SoftX.new(@options)
      when :IMS
        @connection_telnet =  ConnectionTelnet_IMS.new(@options)
      when :UMG
        @connection_telnet =  ConnectionTelnet_UMG.new(@options)
      end
    end
  end

  class IMS < CommutationSystem
    def initialize(options)
      @options = options
      @options[:type] = :IMS
      super # Вызываем конструктор предка (CommutationSystem)
    end
  end

  # Работа с коммутатором NGN SoftX3000
  class SoftX < CommutationSystem
    def initialize(options)
      @options = options
      @options[:type] = :SoftX
      super # Вызываем конструктор предка (CommutationSystem)
    end
  end

  # Работа с UMG
  class UMG < CommutationSystem
    def initialize(options)
      @options = options
      @options[:type] = :UMG
      super # Вызываем конструктор предка (CommutationSystem)
    end
  end

end


# Примеры использования
#
