function Z=polar_generator(node,N,sigma)
    
    [m,~]=size(node);
    Z=zeros(2,m*N);
    test=zeros(m+2,2);
    test(2:m+1,:)=node;
    test(1,:)=node(m,:);
    test(m+2,:)=node(1,:);
    direction=zeros(m,2);
    for i=1:m
        temp=(test(i+1,1)-test(i,1))*(test(i+2,2)-test(i,2))-(test(i+2,1)-test(i,1))*(test(i+1,2)-test(i,2));
        if temp<0
            fprintf('polygon is not convex.');
            %return;
        end
        direction(i,:)=sign(temp)*dire_generator(test(i,:),test(i+1,:),test(i+2,:));
    end

    alpha=exp(-sigma*(0:N-1)./sqrt(N));
    for i=0:m-1
        Z(:,i*N+1:(i+1)*N)=node(i+1,:)'+direction(i+1,:)'*alpha;

    end

end