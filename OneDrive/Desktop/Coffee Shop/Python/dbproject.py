from flask import Flask, render_template, flash, redirect, url_for
from forms import LoginForm, Promotion, Product, Order, DisplayProduct, Report

import cx_Oracle

app = Flask(__name__)
app.config['SECRET_KEY'] = 'a4f9e6d416022b0bb59f12685ea19a24'

# connection to database
con = cx_Oracle.connect(
    'COMP214_W19_87/password@199.212.26.208:1521/SQLD')
cur = con.cursor()
cur1 = con.cursor()
cur2 = con.cursor()


@app.route("/")
@app.route("/home")
def home():

    #cur.execute('select * from departments order by department_id')
    return render_template('home.html', title='home')


@app.route("/login", methods=['GET', 'POST'])
def login():
    form = LoginForm()
    if form.validate_on_submit():
        output = cur.callproc('member_ck_sp', [
            form.username.data, form.password.data, 0, 'INVALID'])
        if output[3] == "VALID":
            # form.username.data == 'admin' and form.password.data == 'admin':
            flash('Welcome ' + output[1] +
                  '. Your login status is ' + output[3], 'success')
            return redirect(url_for('promotion'))
        else:
            flash('Incorrect username or password, Please try again', 'danger')
    return render_template('login.html', form=form, title='login')


@app.route("/promotion", methods=['GET', 'POST'])
def promotion():
    form = Promotion()
    if form.validate_on_submit():
        cur.callproc('promo_ship_sp', [
                     form.day.data, form.month.data, form.year.data])
        return redirect(url_for('promolist'))
    return render_template('promotion.html', form=form, title='promotion')


@app.route("/promolist", methods=['GET'])
def promolist():
    cur.execute('select * from bb_promolist')
    return render_template('promolist.html', cur=cur, title='promolist')


@app.route("/product", methods=['GET', 'POST'])
def product():
    form = Product()
    if form.validate_on_submit():
        idproduct = 0
        id = cur.callproc('Prod_Add_sp', [
            form.name.data, form.description.data, form.image.data, form.price.data, form.status.data, idproduct])
        output = cur.execute(
            'SELECT idproduct, productname, description, productimage, price, active  from BB_PRODUCT where idproduct = :idproduct', idproduct=id[5])
        for result in output:
            flash('A new product has been successfully added. IDPRODUCT = ' +
                  str(result[0]) + ', PRODUCTNAME = ' + str(result[1]), 'success')
    return render_template('product.html', form=form, title='product')


@app.route("/displayproduct", methods=['GET', 'POST'])
def displayProduct():
    form = DisplayProduct()
    if form.validate_on_submit():
        cur.execute(
            'SELECT productname, salestart, saleend, :mydate, ck_sale_sf(idproduct, :mydate) from bb_product WHERE idproduct = :idproduct',
            idproduct=form.productID.data,
            mydate=form.date.data)
        return render_template('displayProduct.html', cur=cur, form=form, title='displayproduct')
    return render_template('displayProduct.html', form=form, title='displayproduct')


@app.route("/order", methods=['GET', 'POST'])
def order():
    form = Order()
    if form.validate_on_submit():
        cur.execute(
            'SELECT idbasket, dtStage, status_desc_sf(idStage) FROM bb_basketstatus WHERE idBasket = :idBasket', idBasket=form.basketID.data)
        return render_template('order.html', cur=cur, form=form, title='order')
    return render_template('order.html', form=form, title='order')


@app.route("/report", methods=['GET', 'POST'])
def report():
    form = Report()
    if form.report1.data:
        cur1.execute(
            'SELECT idshopper, firstname, lastname, TOT_PURCH_SF(BB_SHOPPER.idshopper) AS TOT_PURCH FROM BB_SHOPPER')
        return render_template('report.html', cur1=cur1, form=form, title='report')
    elif form.report2.data:
        cur2.execute(
            'SELECT NUM_PURCH_SF(23) FROM bb_shopper WHERE idshopper=23')
        return render_template('report.html', cur2=cur2, form=form, title='report')
    return render_template('report.html', form=form, title='report')


if __name__ == '__main__':
    app.run(debug=True)
