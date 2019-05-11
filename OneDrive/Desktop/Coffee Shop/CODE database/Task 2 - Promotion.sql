create or replace PROCEDURE PROMO_SHIP_SP 
(p_cutoff IN bb_basket.dtcreated%TYPE,
 p_month IN varchar,
 p_year IN number)
IS

    CURSOR cur_emp IS
        SELECT idshopper, max(dtcreated) as dtcreated FROM bb_basket group by idshopper;
    checkExist number;
BEGIN
    FOR emp_rec IN cur_emp
    LOOP
        -- check if the record exists in the table or not
        SELECT CASE WHEN EXISTS (SELECT * FROM bb_promolist where idshopper = emp_rec.idshopper) 
        THEN 1 ELSE 0 END INTO checkExist
        FROM dual;
        
        -- cut off condition
        IF emp_rec.dtcreated < p_cutoff
        THEN
            -- exist condition: if exist then update else insert
            IF checkExist = 1
            THEN
                UPDATE bb_promolist SET MONTH = p_month, YEAR = p_year, PROMO_FLAG = 1, USED = 'N'
                WHERE IDSHOPPER = emp_rec.idshopper;
            ELSE
                INSERT INTO bb_promolist
                VALUES (emp_rec.idshopper, p_month, p_year, 1, 'N');
            END IF;
        ELSE
            IF checkExist = 1
            THEN
                UPDATE bb_promolist SET MONTH = p_month, YEAR = p_year, PROMO_FLAG = 0, USED = 'N'
                WHERE IDSHOPPER = emp_rec.idshopper;
            ELSE
                INSERT INTO bb_promolist
                VALUES (emp_rec.idshopper, p_month, p_year, 0, 'N');
            END IF;
        END IF;
    END LOOP;
END PROMO_SHIP_SP;