module PID

"""

This module implements a simple P controller.

"""

function compute_control(y::Dict)
    # compute the control input from the measurement.
    # y contains the current values of the measurements.
    # {<measurement_name>:<measurement_value>}
    # compute the control input from the measurement.
    # u: dict Defines the control input to be used for the next step.
    # {<input_name> : <input_value>}

    # control parameters
    LowerSetp = 273.15 + 20
    UpperSetp = 273.15 + 23
    k_p = 2000

    # compute control
    if y["TRooAir_y"]<LowerSetp
        e = LowerSetp - y["TRooAir_y"]
    elseif y["TRooAir_y"]>UpperSetp
        e = UpperSetp - y["TRooAir_y"]
    else
        e = 0
    end

    value = k_p*e
    u = Dict("oveAct_u" => value,"oveAct_activate" => 1)
    return u
end

function initialize()
    # u: dict Defines the initial control input to be used for the next step.
    # {<input_name> : <input_value>}
    u = Dict("oveAct_u" => 0.0,"oveAct_activate" => 1)
    return u
end

end


module sup

"""

This module implements an external signal to overwrite existing controllers in the emulator.

"""

function compute_control(y::Dict)
    # compute the control input from the measurement.
    # y contains the current values of the measurements.
    # {<measurement_name>:<measurement_value>}
    # compute the control input from the measurement.
    # u: dict Defines the control input to be used for the next step.
    # {<input_name> : <input_value>}

    u = Dict("oveTSetRooHea_u" => 22+273.15,"oveTSetRooHea_activate" => 1,"oveTSetRooCoo_u" => 23+273.15,"oveTSetRooCoo_activate" => 1)
    return u
end

function initialize()
    # u: dict Defines the initial control input to be used for the next step.
    # {<input_name> : <input_value>}
    u = Dict("oveTSetRooHea_u" => 22+273.15,"oveTSetRooHea_activate" => 1,"oveTSetRooCoo_u" => 23+273.15,"oveTSetRooCoo_activate" => 1)
    return u
end

end
