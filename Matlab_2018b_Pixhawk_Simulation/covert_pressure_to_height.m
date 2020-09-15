function relative_height = covert_pressure_to_height(pressure, temperature)
R = single(287.058);
g = single(9.81);
temperature = temperature + single(273.15); %convert to kelvin from degrees

persistent itr;
if isempty(itr)
    itr = 0;
end

persistent init_pressure;
if isempty(init_pressure)
    init_pressure = single(944.77);
end

persistent initial_temp;
if isempty(initial_temp)
    initial_temp = temperature;
end

if (itr == 0)
    initial_pressure = pressure;
    itr = itr + 1;
else
    initial_pressure = single(init_pressure);
end

if (isreal(log(initial_pressure/pressure)))
    log_value = log(initial_pressure/pressure);
else
    log_value = 0;
end

init_pressure = single(initial_pressure);

relative_height = single(((R*initial_temp)/g)*log_value);


