function v=dire_generator(x,y,z)
    D=[1 x(1) x(2);1 y(1) y(2);1 z(1) z(2)];
    if det(D)==0
        fprintf('linear dependent!')
        return;
    end

    if (x(2)==z(2))
        v=[0,sign(y(2)-x(2))];
        return;
    end
    if (x(1)==z(1))
        v=[sign(y(1)-x(1)),0];
        return;
    end
    
    v=-det(D)*[x(2)-z(2),z(1)-x(1)];
    v=v/norm(v);

end