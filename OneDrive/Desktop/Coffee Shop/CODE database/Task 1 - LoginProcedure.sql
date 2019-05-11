CREATE OR REPLACE PROCEDURE member_ck_sp (
    p_username   IN           bb_shopper.username%TYPE,
    p_password_name   IN OUT       bb_shopper.lastname%TYPE,
    p_cookie OUT bb_shopper.cookie%TYPE,
    p_check OUT varchar2) 
    AS
    CURSOR c_bb_cursor IS
    SELECT
        username,
        password,
        firstname,
        lastname,
        cookie
    FROM
        bb_shopper;

BEGIN
    p_check := 'INVALID';
    FOR bb_shopper_record IN c_bb_cursor LOOP
        IF p_username = bb_shopper_record.username AND p_password_name = bb_shopper_record.password THEN
            p_password_name := bb_shopper_record.firstname ||' '||bb_shopper_record.lastname;
            p_check := 'VALID';
            p_cookie := bb_shopper_record.cookie;
            EXIT WHEN c_bb_cursor%found;     
        END IF;
    END LOOP;
    IF ( p_check = 'INVALID' ) THEN
    dbms_output.put_line('LOG IN UNSUCCESSFUL!');
    p_cookie :=null;
    p_password_name  := 'No user';
    END IF;
END;
/
declare
v_password_name  bb_shopper.lastname%TYPE;
v_cookie bb_shopper.cookie%TYPE;
v_check varchar2(10);
begin
v_password_name := 'tweak';
member_ck_sp('Fdwell', v_password_name,v_cookie,v_check);
dbms_output.put_line(v_password_name||' '||' '||v_cookie||' '||v_check);
end;
