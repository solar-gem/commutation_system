require "commutation_system/version"

# Реализация подключения к станции по telnet
require "commutation_system/commutation_system_telnet"

# Реализация подключения к станции по протоколу soap
require "commutation_system/commutation_system_soap"


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

    def initialize(options)
      @options = options
      verification # Проверка обязательных параметров

    end

    # Проверка обязательных параметров
    def verification
      # :type => тип станции
      raise ArgumentError.new("There is no option :type") unless @options.has_key?(:type)

      raise ArgumentError.new("There is no option :host") unless @options.has_key?(:host)
      raise ArgumentError.new("There is no option :username") unless @options.has_key?(:username)
      raise ArgumentError.new("There is no option :password") unless @options.has_key?(:password)
    end



  end

  class CommutationSystem_IMS < CommutationSystem
  end

  # Работа с коммутатором NGN SoftX3000
  class CommutationSystem_SoxtX < CommutationSystem
    def initialize
      super(options) # Вызываем конструктор предка (CommutationSystem)
      # Создаём объект подключения к станции по протоколу telnet
      @connection_telnet =  ConnectionTelnet_SoftX.new(@options)

    end

  end
end


# Примеры использования
#
