function index=isinside(node,x)
    [m,~]=size(node);
    test=zeros(m+1,2);
    test(1:m,:)=node;
    test(m+1,:)=node(1,:);
    index=0;
    for i=1:m
        if (test(i,2)-x(2))*(x(2)-test(i+1,2))>0
            temp=x(1)-(x(2)-test(i,2))*(test(i+1,1)-test(i,1))/(test(i+1,2)-test(i,2));
            if test(i+1,1)==test(i,1)
                temp=sign(x(1)-test(i,1));
            end
            
            if temp<=0
                index=index+sign(test(i,2)-test(i+1,2));
            end
        end

    end
    if index~=0
        index=1;
    end

end