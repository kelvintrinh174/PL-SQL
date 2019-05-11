from flask_wtf import FlaskForm
from wtforms import StringField, PasswordField, SubmitField
from wtforms.validators import DataRequired, Length


class LoginForm(FlaskForm):
    username = StringField('Username', validators=[
                           DataRequired(), Length(min=2, max=20)])
    password = PasswordField('Password', validators=[DataRequired()])
    submit = SubmitField('login')


class Promotion(FlaskForm):
    day = StringField('day', validators=[DataRequired()])
    month = StringField('month', validators=[DataRequired()])
    year = StringField('year', validators=[DataRequired()])
    submit = SubmitField('submit')


class Product(FlaskForm):
    name = StringField('name', validators=[DataRequired()])
    description = StringField('description', validators=[DataRequired()])
    image = StringField('image', validators=[DataRequired()])
    price = StringField('price', validators=[DataRequired()])
    status = StringField('status', validators=[DataRequired()])
    submit = SubmitField('submit')


class Order(FlaskForm):
    basketID = StringField('BasketID', validators=[DataRequired()])
    submit = SubmitField('submit')


class DisplayProduct(FlaskForm):
    productID = StringField('productID', validators=[DataRequired()])
    date = StringField('Date', validators=[DataRequired()])
    submit = SubmitField('submit')


class Report(FlaskForm):
    report1 = SubmitField('Report1')
    report2 = SubmitField('Report2')
