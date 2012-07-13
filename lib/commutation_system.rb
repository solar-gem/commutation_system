require "commutation_system/version"

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

    end

    class CommutationSystem_IMS < CommutationSystem


    end
end
