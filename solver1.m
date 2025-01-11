function err=solver1(node,g,N)
    
    tic
    [x,w]=GLnodes(N,0,1);
    fx=@(x0,y0,s,t) -1/(2*pi).*(s-x0)./((s-x0).^2+(t-y0).^2);
    fy=@(x0,y0,s,t) -1/(2*pi).*(t-y0)./((s-x0).^2+(t-y0).^2);
    [m,~]=size(node);
    Node=zeros(m+1,2);
    Node(1:m,:)=node;
    Node(m+1,:)=node(1,:);
    X=zeros(N*m,2);
    xc=sum(node)/m;
    for i=1:m
        X(((i-1)*N+1):i*N,:)=ones(N,1)*Node(i,:)+x*(Node(i+1,:)-Node(i,:));
        %W((i-1)*N+1:i*N)=w;
    end
    v=outer_normal(node);
    b=g(X(:,1),X(:,2));
    A=zeros(m*N,m*N);
    B=zeros(m*N,m*N);
    for j=1:m
        for i=1:N
            A(:,(j-1)*N+i)=norm(Node(j+1,:)-Node(j,:))*w(i)*(v(1,j)*fx(X(:,1),X(:,2),X((j-1)*N+i,1),X((j-1)*N+i,2))+v(2,j)*fy(X(:,1),X(:,2),X((j-1)*N+i,1),X((j-1)*N+i,2)));
        end
    end
    for j=1:m
        A((j-1)*N+1:(j)*N,(j-1)*N+1:(j)*N)=zeros(N,N);
    end


    %求解
    mu=(0.5*eye(m*N)-A)\b;
    elapsedTime = toc;
    disp(['运行时间: ', num2str(elapsedTime), ' 秒']);

    %生成解
    G = @(s, t) 0;  
    for i = 1:m
        for j=1:N
            G = @(s, t) G(s, t) - norm(Node(i+1,:)-Node(i,:))*mu((i-1)*N+j)*w(j)*(v(1,i)*fx(s,t,X((i-1)*N+j,1),X((i-1)*N+j,2))+v(2,i)*fy(s,t,X((i-1)*N+j,1),X((i-1)*N+j,2)));
        end
    end

    [x0, y0] = meshgrid(min(node(:,1)):0.01:max(node(:,1)), min(node(:,2)):0.01:max(node(:,2))); 

    [nx,ny]=size(x0);
    x1=zeros(nx,ny);
    y1=zeros(nx,ny);
    ind=0;
    
    z=G(x0,y0);
    h=g(x0,y0);
    r=abs(z-h);
    theta=1;
    for i=1:nx
        for j=1:ny
            if isinside(node,[x0(i,j),y0(i,j)])==1
                ind=ind+1;
                x1(i,j)=x0(i,j);
                y1(i,j)=y0(i,j);
                % for k=1:m
                % 
                %     l((k-1)*N+1:k*N)=norm(Node(k+1,:)-Node(k,:))*w.*(v(1,k)*fx(x1(i,j),y1(i,j),X((k-1)*N+1:k*N,1),X((k-1)*N+1:k*N,2))+v(2,k)*fy(x1(i,j),y1(i,j),X((k-1)*N+1:k*N,1),X((k-1)*N+1:k*N,2)));
                % end
                % val(i,j)=l*mu;
            end
            if isinside(theta*node+(1-theta)*ones(m,1)*xc,[x0(i,j),y0(i,j)])==0
                z(i,j)=0;
                r(i,j)=0;
            end
        end
    end



    
    mesh(x0,y0,z);
    %mesh(x0,y0,r); 
    xlabel('x');
    ylabel('y');
    zlabel('U(x,y)');
    title('solver1');
    
    %max(r(2:ind-1))
    err=sum(sum(r))/ind;
    





end