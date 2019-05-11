CREATE OR REPLACE PROCEDURE prod_add_sp(
    p_name          IN bb_product.productname%TYPE,
    p_description   IN bb_product.description%TYPE,
    p_image         IN bb_product.productimage%TYPE,
    p_price         IN bb_product.price%TYPE,
    p_status        IN bb_product.active%TYPE,
    p_id            OUT bb_product.idproduct%TYPE
)
IS
BEGIN
    p_id := bb_prodid_seq.NEXTVAL;
    INSERT INTO bb_product(
                    idproduct,
                    productname,
                    description,
                    productimage,
                    price,
                    active
                )
    VALUES (
               p_id,
               p_name,
               p_description,
               p_image,
               p_price,
               p_status
           );

    COMMIT;
END;

DECLARE
p_id       bb_product.idproduct%TYPE;
BEGIN
Prod_Add_sp( 'Roasted Blend', 'Well-balanced mix of roasted beans', 'roasted.jpg', 9, 1,p_id);
DBMS_OUTPUT.PUT_LINE(p_id);
END;

--SELECT * FROM BB_PRODUCT order by idproduct;

