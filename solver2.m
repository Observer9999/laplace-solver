function err=solver2(node,g,N,tol)
    sigma=1.6;
    itermax=50000;
    n=N;
    l=N-1;
    [m,~]=size(node);
    n2=floor(3*(2*n+2*l+1)/m);
    Node=zeros(m+1,2);
    Node(1:m,:)=node;
    Node(m+1,:)=node(1,:);
    Z=polar_generator(node,N,sigma);
    cen=sum(node)./m;
    [x,~]=GLnodes(n2,0,1);
    X=zeros(n2*m,2);
    for i=1:m
        X(((i-1)*n2+1):i*n2,:)=ones(n2,1)*Node(i,:)+x*(Node(i+1,:)-Node(i,:));
    end
    A=zeros(n2*m,m*N+l);
    for i=1:n2*m
        for j=1:N*m
            A(i,j)=1/(X(i,1)-Z(1,j)+1i*(X(i,2)-Z(2,j)));    %i-th point
        end
        for k=1:l
            A(i,m*N+k)=(X(i,1)-cen(1)+1i*(X(i,2)-cen(2)))^(k-1);
        end
    end
    b=g(X(:,1),X(:,2));
    A=real(A);
    c=lsqr(A,b,tol,itermax);

        
    G = @(s, t) 0;  
    for i = 1:m*N
        G = @(s, t) G(s, t) + c(i) ./ (s - Z(1, i) + 1i * (t - Z(2, i)));
    end
    for i=1:l
        G = @(s, t) G(s, t) + c(m*N+i).*(s-cen(1)+1i*(t-cen(2))).^(i-1);
    end
    
    h=@(s,t) real(G(s,t));

    [x0, y0] = meshgrid(min(node(:,1)):0.01:max(node(:,1)), min(node(:,2)):0.01:max(node(:,2))); 

    [nx,ny]=size(x0);
    x1=zeros(nx,ny);
    y1=zeros(nx,ny);
    ind=0;
      % 计算函数值
    z = h(x0, y0);
    w = g(x0,y0);
    r=abs(z-w);
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
            if isinside(theta*node+(1-theta)*ones(m,1)*cen,[x0(i,j),y0(i,j)])==0
                z(i,j)=0;
                %w(i,j)=0;
                r(i,j)=0;
            end
        end
    end

    %z = h(x1, y1);

    % 绘制图像
    %mesh(x0, y0, r);
    mesh(x0,y0,z);
    %hold on
    %plot3(x,y,z-w);
    xlabel('x');
    ylabel('y');
    zlabel('U(x,y)');
    title('solver2');


    %max(r(2:ind-1))
    err=sum(sum(r))/ind;

end

