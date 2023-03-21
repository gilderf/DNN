function [step, tmp_data] = criteria(gradient, tmp_data, name, params)
    switch name
        case 'default'
            step = gradient;
        case 'nesterov'
            tmp_data = params(1)*tmp_data + (1 - params(1))*gradient;
            step = tmp_data;
        case 'adagrad'
            tmp_data = tmp_data + gradient.^2;
            step = gradient ./ sqrt(tmp_data + params(1));
        case 'rmsprop'
            tmp_data = params(1)*tmp_data + (1 - params(1))*gradient.^2;
            step = gradient ./ sqrt(tmp_data + params(2));
        case 'adam'
            tmp_data = params(1)*real(tmp_data) + (1 - params(1))*gradient + ...
                   1i*(params(2)*imag(tmp_data) + (1 - params(2))*gradient.^2);
            step = real(tmp_data)/(1 - params(1)^params(4))./ ...
                sqrt(imag(tmp_data)/(1 - params(2)^params(4)) + params(3));
        otherwise
            error(['criteria "' name '" is not exist']);
    end
end

