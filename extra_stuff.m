        %norm_list=[norm_list norm((ae-h(:,p)'),2)];
        %if abs(norm((ae-h(:,p)'),2) - 3.3556) < 0.001
            %norm((ae-h(:,p)'),2);
            %p;
            %e;
            %disp_face(a(:,e,p));
            %pause(0.5);
        %end
        if norm((ae-h(:,p)'),2) < 0.001
            %min = norm((ae-h(:,p)'),2);
            %k = p;
        end
        
        min_norm=min(norm_list)