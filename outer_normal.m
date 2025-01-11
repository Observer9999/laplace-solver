function V=outer_normal(node)
    [m,~]=size(node);    
    Node=zeros(m+1,2);
    Node(1:m,:)=node;
    Node(m+1,:)=node(1,:);
    V=zeros(2,m);
    D=[0 1;-1 0];
    for i=1:m
        V(:,i)=D*(Node(i+1,:)-Node(i,:))';
        V(:,i)=V(:,i)./norm(V(:,i));
    end

end