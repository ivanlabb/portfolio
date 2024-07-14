




import telebot
from telebot import types
import datetime
from mysql.connector import connect, Error
from getpass import getpass
from datetime import datetime
import re

bot = telebot.TeleBot('5348419377:AAFRR7QYBSDnsGRqv-kO4lqhno1fpUVMxD4')
excur_up = {'Индивидуальная': ['Башенка', 'Мекс', 'Хогвартс', 'Политка', 'Фонтанка'], 'Групповая': ['Башенка']}
excur_down = ['Контрасты без крыши']
kombi = ['Сердце Петербурга', 'Контрасты с крышей', 'Секреты Петроградки', 'Секреты лайт']

places = {'Крыши': excur_up, 'Парадные': excur_down,
          'Комбо': kombi}


def block(name_, tip, cat, name_exc,callback):
    try:
        with connect(
                host="localhost",
                user="root",
                password="itmo",
                database="bot3",
        ) as connection:
            select = f"""
                    call bot3.add_block('{name_}', '{tip}', '{cat}', '{name_exc}'); """
            with connection.cursor() as cursor:
                cursor.execute(select)
                connection.commit()

    except Error as e:
        button_call(callback,["Блок места для гида"],"Такого гида нет")
        print(e)


def delete_workhours(id, date_):
    try:
        with connect(
                host="localhost",
                user="root",
                password="itmo",
                database="bot3",
        ) as connection:
            select = f"""
                    call bot3.del_workhours('{id}', '{date_}'); """
            with connection.cursor() as cursor:
                cursor.execute(select)
                connection.commit()

    except Error as e:
        print(e)


def guides_sql(itog):
    try:
        with connect(
                host="localhost",
                user="root",
                password="itmo",
                database="bot3",
        ) as connection:
            insert_reviewers_query = """
            INSERT INTO workhours
            (id_guide, workdate, timest, timeend)
            VALUES (%s, %s, %s, %s)
            """
            rec = []
            rec.append(tuple(itog))
            with connection.cursor() as cursor:
                cursor.executemany(insert_reviewers_query,
                                   rec)
                connection.commit()
    except Error as e:
        print(e)




def button_call(callback, massiv, texti):
    prmt_keyboard = types.InlineKeyboardMarkup()
    for i in massiv:
        prmt_keyboard.add(types.InlineKeyboardButton(text=i, callback_data=i))
    bot.edit_message_text(chat_id=callback.message.chat.id, message_id=callback.message.id, text=texti,
                          reply_markup=prmt_keyboard)


def button_mes(message: object, massiv: object, texti: object) -> object:
    prmt_keyboard = types.InlineKeyboardMarkup()
    for i in massiv:
        prmt_keyboard.add(types.InlineKeyboardButton(text=i, callback_data=i))

    bot.send_message(message.chat.id, texti, reply_markup=prmt_keyboard)


def gid_namer(a):
    try:
        with connect(
                host="localhost",
                user="root",
                password="itmo",
                database="bot3",
        ) as connection:
            namer = []
            selec_time_query = f"""
select name_guide from guide join
(select id_guide from workhours where workdate = "{a}") as q1 
on q1.id_guide = guide.id_guide;"""

            with connection.cursor() as cursor:
                cursor.execute(selec_time_query)
                for row in cursor.fetchall():
                    namer.append(row[0])
                return namer

    except Error as e:
        print(e)




def name():
    try:
        with connect(
                host="localhost",
                user="root",
                password="itmo",
                database="bot3",
        ) as connection:
            namer = []
            selec_time_query = f"""
    select name_guide from guide;"""

            with connection.cursor() as cursor:
                cursor.execute(selec_time_query)
                for row in cursor.fetchall():
                    namer.append(row[0])
                return namer

    except Error as e:
        print(e)


def prov_time(massiv, namer):
    try:
        with connect(
                host="localhost",
                user="root",
                password="itmo",
                database="bot3",
        ) as connection:
            connectiom = []
            for name in namer:
                selec_time_query = f"""select bot3.is_guide_available('{massiv[0]}', '{massiv[1]}',
                '{massiv[2]}','{massiv[3]}','{massiv[4]}','{name}');"""
                with connection.cursor() as cursor:
                    cursor.execute(selec_time_query)
                    for row in cursor.fetchall():
                        if row[0] == 1:
                            connectiom.append(name)
            return connectiom
    except Error as e:
        print(e)


def neraspr(date):
    global feedback
    feedback = {}
    try:
        with connect(
                host="localhost",
                user="root",
                password="itmo",
                database="bot3",
        ) as connection:
            select = f"""
                     select id_apply, type_excur,category_excur,name_excur,date_app,time_app,amount_app,infa,comment,login_promik from excurtion join apply 
on excurtion.id_excur = apply.id_excur 
join promik
on promik.id_promik = apply.id_promik
where date_app = '{date}' and id_guide is Null order by time_app;"""
            with connection.cursor() as cursor:
                cursor.execute(select)
                for row in cursor.fetchall():
                    feedback[str(row[0])] = row[1:len(row)]

            return feedback

    except Error as e:
        print(e)


def gid_naznach(massiv):
    try:
        with connect(
                host="localhost",
                user="root",
                password="itmo",
                database="bot3",
        ) as connection:
            select = f"""
                        update apply set id_guide = (select id_guide from guide where name_guide = '{massiv[1]}')
where id_apply = {int(massiv[0])}"""
            with connection.cursor() as cursor:
                cursor.execute(select)
                connection.commit()

            return feedback

    except Error as e:
        print(e)


def gid_adr(name):
    try:
        with connect(
                host="localhost",
                user="root",
                password="itmo",
                database="bot3",
        ) as connection:
            select = f"""
                    call bot3.add_guide('{name}');"""
            with connection.cursor() as cursor:
                cursor.execute(select)
                connection.commit()

    except Error as e:
        print(e)


def all_exc(date):
    global feedback
    feedback = {}
    try:
        with connect(
                host="localhost",
                user="root",
                password="itmo",
                database="bot3",
        ) as connection:
            select = f"""
                    select id_apply, type_excur,category_excur,name_excur,date_app,time_app,amount_app,infa,comment,
if((select name_guide from guide where apply.id_guide = guide.id_guide) is Null,'Гид не назначен'
,(select name_guide from guide where apply.id_guide = guide.id_guide)),
(select login_promik from promik where promik.id_promik = apply.id_promik )from excurtion join apply 
on excurtion.id_excur = apply.id_excur 
where date_app = '{date}' order by time_app;"""
            with connection.cursor() as cursor:
                cursor.execute(select)
                for row in cursor.fetchall():
                    feedback[str(row[0])] = row[1:len(row)]
            return feedback

    except Error as e:
        print(e)


def excurtion():
    global feedback
    feedback = {}
    try:
        with connect(
                host="localhost",
                user="root",
                password="itmo",
                database="bot3",
        ) as connection:
            select = f"""
                    select id_excur,type_excur,category_excur,name_excur from excurtion;"""
            with connection.cursor() as cursor:
                cursor.execute(select)
                for row in cursor.fetchall():
                    feedback[str(row[0])] = row[1:len(row)]

            return feedback

    except Error as e:
        print(e)


def Id_gid_by_name(name_gid):
    try:
        with connect(
                host="localhost",
                user="root",
                password="itmo",
                database="bot3",
        ) as connection:

            select = f"""
                    select id_guide from guide where name_guide = '{name_gid}' """
            with connection.cursor() as cursor:
                cursor.execute(select)
                for row in cursor.fetchall():
                    return row[0]
    except Error as e:
        print(e)


def blocks():
    try:
        with connect(
                host="localhost",
                user="root",
                password="itmo",
                database="bot3",
        ) as connection:
            dictionary = {}
            num_zap = 0
            select = f"""select guide.name_guide, type_excur,category_excur,name_excur from denied_by_guides
join guide
on guide.id_guide = denied_by_guides.id_guide
join excurtion 
on excurtion.id_excur = denied_by_guides.id_excur;"""
            with connection.cursor() as cursor:
                cursor.execute(select)
                for row in cursor.fetchall():
                    num_zap += 1
                    dictionary[str(num_zap)] = row
            return dictionary
    except Error as e:
        print(e)

def delete_blocker(denir):
    try:
        with connect(
                host="localhost",
                user="root",
                password="itmo",
                database="bot3",
        ) as connection:
            select = f"""
                    call bot3.delete_block('{denir[0]}','{denir[1]}','{denir[2]}','{denir[3]}');
                     """
            with connection.cursor() as cursor:
                cursor.execute(select)
                connection.commit()

    except Error as e:
        print(e)


def zapi_izmener_vtor(massiv):
    try:
        with connect(
                host="localhost",
                user="root",
                password="itmo",
                database="bot3",
        ) as connection:
            select = f"""
                    call bot3.izmener('{massiv[1]}', '{massiv[3]}', '{massiv[2]}');"""
            with connection.cursor() as cursor:
                cursor.execute(select)
                connection.commit()

    except Error as e:
        print(e)

def zapi_izmener_per(massiv):
    try:
        with connect(
                host="localhost",
                user="root",
                password="itmo",
                database="bot3",
        ) as connection:
            select = f"""
                    call bot3.izmener_id_exc('{massiv[1]}', '{massiv[3]}', '{massiv[4]}', '{massiv[5]}');"""
            with connection.cursor() as cursor:
                cursor.execute(select)
                connection.commit()

    except Error as e:
        print(e)


def timerlan(denir):
    try:
        with connect(
                host="localhost",
                user="root",
                password="itmo",
                database="bot3",
        ) as connection:
            select = f"""
                    call bot3.add_spec_workhours('{denir[0]}','{denir[1]}','{denir[2]}','{denir[3]}','{denir[4]}','{denir[5]}');
                     """
            with connection.cursor() as cursor:
                cursor.execute(select)
                connection.commit()

    except Error as e:
        print(e)


@bot.message_handler(commands=['start'])
def start_kb(message):
    start_keyboard = types.ReplyKeyboardMarkup(row_width=1, resize_keyboard=True, one_time_keyboard=True)
    zad1 = types.KeyboardButton(text="Распределить экскурсии")
    zad2 = types.KeyboardButton(text="Работа с гидами")
    """
    zad3 = types.KeyboardButton(text="Заблокировать запись")
    """
    start_keyboard.add(zad1, zad2)
    bot.send_message(message.chat.id, "Привет! Выбери задачу", reply_markup=start_keyboard)


@bot.message_handler(func=lambda m: m.text == 'Распределить экскурсии')
def rasp(message):
    masiiv = ["Просмотреть не-нные экскурсии","Изменить запись","Все экскурсии по дате","Удаление записи"]
    button_mes(message,masiiv,'Сделайте выбор')







@bot.callback_query_handler(func=lambda c: c.data in ["Изменить запись","Некорректный выбор"])
def date_prosmotr(callback):
    com = bot.edit_message_text(chat_id=callback.message.chat.id, message_id=callback.message.id,
                                text="Введите дату в формате дата. месяц")
    bot.register_next_step_handler(com, domingos)


def domingos(message):
    global zapis
    try:
        zapis = {}
        zapis[message.chat.id] = [datetime.strptime(message.text + ".22", '%d.%m.%y'),"2"]
        k = 0
        if all_exc(zapis[message.chat.id][0]) != {}:
            for i in all_exc(zapis[message.chat.id][0]).keys():
                k += 1
                text1 = f"Запись номер: {str(i)}\n1) {str(all_exc(zapis[message.chat.id][0])[i][0])}\n2) {str(all_exc(zapis[message.chat.id][0])[i][1])}\n3) {str(all_exc(zapis[message.chat.id][0])[i][2])}\n4) {str(all_exc(zapis[message.chat.id][0])[i][3])}\n" \
                            f"5) {str(all_exc(zapis[message.chat.id][0])[i][4])}\n6) {str(all_exc(zapis[message.chat.id][0])[i][5])}\n7) {str(all_exc(zapis[message.chat.id][0])[i][6])}\n8) {str(all_exc(zapis[message.chat.id][0])[i][7])}\n9) {str(all_exc(zapis[message.chat.id][0])[i][8])}\n10) {str(all_exc(zapis[message.chat.id][0])[i][9])}\n"
                bot.send_message(message.chat.id, text=text1)
            numzap = bot.send_message(chat_id=message.chat.id,
                                      text="Введите номер записи, которую вы хотите изменить")
            bot.register_next_step_handler(numzap, vener)

        else:
            no_guides = types.InlineKeyboardMarkup()
            btn2 = types.InlineKeyboardButton(text='Другая дата', callback_data="Просмотреть не-нные экскурсии")
            no_guides.row(btn2)
            bot.send_message(message.chat.id, 'Нераспределенных экскурсий нет. Вы можете выбрать другую дату:',
                             reply_markup=no_guides)

    except ValueError:
        bot.send_message(chat_id=message.chat.id,
                         text="Я вас не понимаю:( Введите дату в формате дата.месяц, например, 31.05")
        z = types.InlineKeyboardMarkup()
        btn148 = types.InlineKeyboardButton(text='Ещё раз', callback_data="Изменить запись")
        z.add(btn148)
        bot.send_message(message.chat.id, 'Попробовать ещё раз', reply_markup=z)


def vener(message):
    zapis[message.chat.id][1] = message.text
    button_mes(message,["Корректный выбор","Некорректный выбор"],"Вы выбрали запись номер " + message.text)


@bot.callback_query_handler(func=lambda c: c.data == "Корректный выбор" or c.data == "Попробовать ещё")
def reshala(callback):
    try:
        zapis[callback.message.chat.id] = zapis[callback.message.chat.id][0:2]
        tixi = f'\nВы выбрали запись номер: {zapis[callback.message.chat.id][1]}\n'
        k = 0
        for elem in all_exc(zapis[callback.message.chat.id][0])[zapis[callback.message.chat.id][1]]:
            k += 1
            tixi += f"{str(k)}){elem}\n"

        numzap = bot.edit_message_text(chat_id=callback.message.chat.id, message_id=callback.message.id,
                                  text="Введите пункт, который вы хотите изменить в данной записи\n" + tixi)
        bot.register_next_step_handler(numzap, bombini)
    except ValueError:
        bot.send_message(chat_id=callback.message.chat.id,
                         text="Упс, что-то не то. Давайте еще раз!")
        button_call(callback,["Некорректный выбор"],"Нажмите")
    except KeyError:
        bot.send_message(chat_id=callback.message.chat.id,
                         text="Упс, что-то не то. Давайте еще раз!")
        button_call(callback, ["Некорректный выбор"], "Нажмите")

def bombini(message):
    try:
        zapis[message.chat.id]= zapis[message.chat.id][0:2]
        zapis[message.chat.id].append(message.text)
        global position
        position = message.text
        if int(message.text) in [1,2,3]:
            text = ''
            k = 0
            for i in all_exc(zapis[message.chat.id][0])[zapis[message.chat.id][1]][0:3]:
                k += 1
                if k == int(message.text):
                    zapis[message.chat.id].append("")
                else:
                    zapis[message.chat.id].append(i)
            text += f'{all_exc(zapis[message.chat.id][0])[zapis[message.chat.id][1]][int(message.text)-1]}\n'
            numzap = bot.send_message(chat_id=message.chat.id,
                                               text=f"Введите то, на что хотите заменить:{text}")
            bot.register_next_step_handler(numzap, bombinir)
        elif int(message.text) in [4,5,6,7,8,9,10]:
            numzap = bot.send_message(chat_id=message.chat.id,
                                           text=f"Введите то, на что хотите заменить:{all_exc(zapis[message.chat.id][0])[zapis[message.chat.id][1]][int(message.text)-1]}")
            bot.register_next_step_handler(numzap, bombinir)

    except ValueError:
        bot.send_message(chat_id=message.chat.id,
                         text="Упс, что-то не то. Давайте еще раз!")
        button_mes(message, ["Попробовать ещё"], "Нажмите")
    except KeyError:
        bot.send_message(chat_id=message.chat.id,
                         text="Упс, что-то не то. Давайте еще раз!")
        button_mes(message, ["Попробовать ещё"], "Нажмите")



def bombinir(message):
    global mes
    mes = message.text
    button_mes(message,["Да!","Попробовать ещё"],f"Верный ввод {message.text}?")

@bot.callback_query_handler(func=lambda c: c.data == "Да!")
def riga(callback):
    if position in ["1","2","3"]:
        zapis[callback.message.chat.id][int(position) + 2] = mes
        zapi_izmener_per(zapis[callback.message.chat.id])
    else:
        zapis[callback.message.chat.id].append(mes)
        zapi_izmener_vtor(zapis[callback.message.chat.id])
    bot.edit_message_text(chat_id=callback.message.chat.id, message_id=callback.message.id,
                          text="Жми /start или на кнопки внизу,чтобы перейти к началу")


@bot.callback_query_handler(func=lambda c: c.data == "Просмотреть не-нные экскурсии"
                                           or c.data == "Нет" or c.data == "Выбрать другую запись")
def date_prosmotr(callback):
    com = bot.edit_message_text(chat_id=callback.message.chat.id, message_id=callback.message.id,
                                text="Введите дату в формате дата. месяц")
    bot.register_next_step_handler(com, daties)


def daties(message):

    global date
    global zapis

    try:
        date = datetime.strptime(message.text + ".22", '%d.%m.%y')
        k = 0
        global id
        if neraspr(date) != {}:
            for i in neraspr(date).keys():
                k += 1
                text1 = f"Запись номер: {str(i)}\n1) {str(neraspr(date)[i][0])}\n2) {str(neraspr(date)[i][1])}\n3) {str(neraspr(date)[i][2])}\n4) {str(neraspr(date)[i][3])}\n" \
                        f"5) {str(neraspr(date)[i][4])}\n6) {str(neraspr(date)[i][5])}\n7) {str(neraspr(date)[i][6])}\n8) {str(neraspr(date)[i][7])}\n9) {str(neraspr(date)[i][8])}\n"

                bot.send_message(message.chat.id, text=text1)
            numzap = bot.send_message(chat_id=message.chat.id,
                                      text="Введите номер записи, на которую вы хотите назначить гида")
            bot.register_next_step_handler(numzap, vybr_guides)

        else:
            no_guides = types.InlineKeyboardMarkup()
            btn2 = types.InlineKeyboardButton(text='Другая дата', callback_data="Просмотреть не-нные экскурсии")
            no_guides.row(btn2)
            bot.send_message(message.chat.id, 'Нераспределенных экскурсий нет. Вы можете выбрать другую дату:',
                             reply_markup=no_guides)

    except ValueError:
        bot.send_message(chat_id=message.chat.id,
                         text="Я вас не понимаю:( Введите дату в формате дата.месяц, например, 31.05")
        z = types.InlineKeyboardMarkup()
        btn1488 = types.InlineKeyboardButton(text='Ещё раз', callback_data="Просмотреть не-нные экскурсии")
        z.add(btn1488)
        bot.send_message(message.chat.id, 'Попробовать ещё раз', reply_markup=z)


def vybr_guides(message):
    global mas
    mas = {}

    mas[message.chat.id] = [message.text]
    try:
        if prov_time(neraspr(date)[message.text], gid_namer(neraspr(date)[message.text][3])) != []:
            button_mes(message, prov_time(neraspr(date)[message.text], gid_namer(neraspr(date)[message.text][3])),
                   "Выберите доступного гида")
        else:
            button_mes(message, ["Ввести имя гида вручную", "Выбрать другую запись"], "К сожалению, свободных гидов нет")
    except KeyError:
        button_mes(message,["Выбрать другую запись"],"Вы неправильно ввели номер записи")

@bot.callback_query_handler(func=lambda c: c.data == "Ввести имя гида вручную")
def vvod_name(callback):
    numzap = bot.send_message(callback.message.chat.id, "Введите имя гида")
    bot.register_next_step_handler(numzap, vvod_name)


def vvod_name(message):
    mas[message.chat.id].append(message.text)
    texter = ''
    texter += f"На запись номер: {str(mas[message.chat.id][0])}\n" \
              f"Назначен гид: {str(mas[message.chat.id][1])}\n"
    button_mes(message, ["Да", "Нет"], "Все верно?\n" + texter)


@bot.callback_query_handler(func=lambda c: c.data in name())
def naznachit(callback):
    k = 0
    texter = ''
    mas[callback.message.chat.id].append(callback.data)
    texter += f"На запись номер: {str(mas[callback.message.chat.id][0])}\n" \
              f"Назначен гид: {str(mas[callback.message.chat.id][1])}\n"

    button_call(callback, ["Да", "Нет"], "Все верно?\n" + texter)


@bot.callback_query_handler(func=lambda c: c.data == "Да")
def naznachiter(callback):
    gid_naznach(mas[callback.message.chat.id])
    mas[callback.message.chat.id] = []
    bot.edit_message_text(chat_id=callback.message.chat.id, message_id=callback.message.id,
                          text="Жми /start или на кнопки внизу,чтобы перейти к началу")


@bot.callback_query_handler(func=lambda c: c.data == "Все экскурсии по дате")
def date_all(callback):
    com = bot.edit_message_text(chat_id=callback.message.chat.id, message_id=callback.message.id,
                                text="Введите дату в формате дата. месяц")
    bot.register_next_step_handler(com, datiners)


def datiners(message):
    miner = {}
    miner[message.chat.id] = message.text
    global datik
    global zapis

    try:
        datik = datetime.strptime(miner[message.chat.id] + ".22", '%d.%m.%y')
        k = 0
        global id
        if all_exc(datik) != {}:
            for i in all_exc(datik).keys():
                k += 1
                text1 = f"Запись номер: {str(i)}\n1) {str(all_exc(datik)[i][0])}\n2) {str(all_exc(datik)[i][1])}\n3) {str(all_exc(datik)[i][2])}\n4) {str(all_exc(datik)[i][3])}\n" \
                        f"5) {str(all_exc(datik)[i][4])}\n6) {str(all_exc(datik)[i][5])}\n7) {str(all_exc(datik)[i][6])}\n8) {str(all_exc(datik)[i][7])}\n9) {str(all_exc(datik)[i][8])}\n10) {str(all_exc(datik)[i][9])}\n"

                bot.send_message(message.chat.id, text=text1)

        else:
            no_guides = types.InlineKeyboardMarkup()
            btn2 = types.InlineKeyboardButton(text='Другая дата', callback_data="Все экскурсии по дате")
            no_guides.row(btn2)
            bot.send_message(message.chat.id, 'Экскурсий на эту дату нет. Вы можете выбрать другую дату:',
                             reply_markup=no_guides)
    except ValueError:
        bot.send_message(chat_id=message.chat.id,
                         text="Я вас не понимаю:( Введите дату в формате дата.месяц, например, 31.05")
        z = types.InlineKeyboardMarkup()
        btn1488 = types.InlineKeyboardButton(text='Ещё раз', callback_data="Просмотреть не-нные экскурсии")
        z.add(btn1488)
        bot.send_message(message.chat.id, 'Попробовать ещё раз', reply_markup=z)



@bot.message_handler(func=lambda m: m.text == 'Работа с гидами')
def work_with_guides(message):
    button_mes(message, ["Добавление гида", "Рабочее время гида", "Блок места для гида","Снятие блока","Время до точки"], "Сделайте выбор")


@bot.callback_query_handler(func=lambda c: c.data in ["Снятие блока","Неверный выбор"])
def sniat(callback):
    texx = ''
    for block in blocks().keys():
        texx = f"""Запись номер: {block}\nИмя: {blocks()[block][0]}\nТип: {blocks()[block][1]}\nКатегория: {blocks()[block][2]}\nНазвание: {blocks()[block][3]}\n"""
        bot.send_message(callback.message.chat.id, text=texx)

    numer = bot.send_message(chat_id=callback.message.chat.id,
                                      text="Введите номер записи, блок для гида с которой вы хотите снять")
    bot.register_next_step_handler(numer, sniat_block)

def sniat_block(message):
    try:
        global id_text
        id_text = {}
        id_text[message.chat.id] = blocks()[message.text]
        button_mes(message,["Верный выбор","Неверный выбор"],f"Вы выбрали запись номер: {message.text}\nВсе верно?")
    except KeyError:
        button_mes(message,["Снятие блока"],"Неверный ввод, попробуйте еще раз")


@bot.callback_query_handler(func=lambda c: c.data == "Верный выбор")
def itodering(callback):
    delete_blocker(id_text[callback.message.chat.id])
    bot.edit_message_text(chat_id=callback.message.chat.id, message_id=callback.message.id, text=
    "Гид создан.Жми /start или на кнопки внизу,чтобы перейти к началу")


@bot.callback_query_handler(func=lambda c: c.data in ["Добавление гида", "Ввести еще раз"])
def guide_namer(callback):
    global gid_n
    gid_n = {}
    numzap1 = bot.send_message(callback.message.chat.id, "Введите имя гида")
    bot.register_next_step_handler(numzap1, gid_name_prov)


def gid_name_prov(message):
    if message.text not in name():
        gid_n[message.chat.id] = message.text
        button_mes(message, ["Верный ввод", "Ввести еще раз"], "Проверьте корректность написания " + message.text)
    else:
        button_mes(message, ["Ввести еще раз"], "Такой гид есть")

@bot.callback_query_handler(func=lambda c: c.data == "Верный ввод")
def guide_adders(callback):
    gid_adr(gid_n[callback.message.chat.id])
    gid_n[callback.message.chat.id] = ""
    bot.edit_message_text(chat_id=callback.message.chat.id, message_id=callback.message.id, text=
    "Гид создан.Жми /start или на кнопки внизу,чтобы перейти к началу")


@bot.callback_query_handler(func=lambda c: c.data == 'Рабочее время гида')
def work_with_guides2(callback):
    confirm_keyboard = types.InlineKeyboardMarkup()
    True_ = types.InlineKeyboardButton(text="Добавить рабочие часы", callback_data="Добавить рабочие часы")
    False_ = types.InlineKeyboardButton(text="Удалить рабочие часы", callback_data="Удалить рабочие часы")
    confirm_keyboard.row(True_, False_)
    bot.send_message(callback.message.chat.id, "Сделайте выбор", reply_markup=confirm_keyboard)


@bot.callback_query_handler(func=lambda c: c.data == "Добавить рабочие часы")
def guide_namer_2(callback):
    global gid_t
    gid_t = {}
    numzap2 = bot.send_message(callback.message.chat.id, "Введите имя гида")
    bot.register_next_step_handler(numzap2, guide_ad)


def guide_ad(message):
    if message.text in name():
        gid_t.update({message.chat.id: [message.text]})
        h = bot.send_message(message.chat.id, "Введите дату")
        bot.register_next_step_handler(h, data_ad)
    else:
        button_mes(message,["Добавить рабочие часы"],"Такого гида нет")


def data_ad(message):

    try:
        f = datetime.strptime(message.text + ".22", '%d.%m.%y')
        gid_t[message.chat.id].append(f)
        h = bot.send_message(message.chat.id, "Введите время начала работы")
        bot.register_next_step_handler(h, time_ad)
    except ValueError:
        bot.send_message(chat_id=message.chat.id,
                         text="Я вас не понимаю:( Введите дату в формате дата.месяц, например, 31.05")
        z = types.InlineKeyboardMarkup()
        btn1488 = types.InlineKeyboardButton(text='Ещё раз', callback_data='Добавить рабочие часы')
        z.add(btn1488)
        bot.send_message(message.chat.id, 'Попробовать ещё раз', reply_markup=z)


def time_ad(message):
    if len(message.text) == 4:
        message.text = '0' + message.text
    message.text = message.text + ':00'
    if re.match(r'[0-5]{1}[0-9]{1}:[0-5]{1}[0-9]{1}:[0-5]{1}[0-9]{1}', message.text):
        gid_t[message.chat.id].append(message.text)
        h = bot.send_message(message.chat.id, "Введите время конца работы")
        bot.register_next_step_handler(h, time_ad2)
    else:
        bot.send_message(chat_id=message.chat.id,
                         text="Я вас не понимаю:( Введите время в формате часы:минуты, например, 10:00")
        z = types.InlineKeyboardMarkup()
        btn1488 = types.InlineKeyboardButton(text='Ещё раз', callback_data='Добавить рабочие часы')
        z.add(btn1488)
        bot.send_message(message.chat.id, 'Попробовать ещё раз', reply_markup=z)


def time_ad2(message):
    if len(message.text) == 4:
        message.text = '0' + message.text
    message.text = message.text + ':00'
    if re.match(r'[0-5]{1}[0-9]{1}:[0-5]{1}[0-9]{1}:[0-5]{1}[0-9]{1}', message.text):
        gid_t[message.chat.id].append(message.text)
        bot.send_message(message.chat.id,
                         text=f"Проверьте данные:\n1)Гид: {gid_t[message.chat.id][0]}\n2)Дата: {str(gid_t[message.chat.id][1])[0:10]}\n3)Время начала работы: {gid_t[message.chat.id][2]}\n4)Время окончания работы: {gid_t[message.chat.id][3]}")
        confirm_keyboard = types.InlineKeyboardMarkup()
        True_ = types.InlineKeyboardButton(text="Всё верно!", callback_data="True")
        False_ = types.InlineKeyboardButton(text="Неверно, назначить ещё раз", callback_data="Добавить рабочие часы")
        confirm_keyboard.add(True_, False_)
        bot.send_message(message.chat.id, "Запись верна?", reply_markup=confirm_keyboard)
    else:
        bot.send_message(chat_id=message.chat.id,
                         text="Я вас не понимаю:( Введите время в формате часы:минуты, например, 10:00")
        z = types.InlineKeyboardMarkup()
        btn1488 = types.InlineKeyboardButton(text='Ещё раз', callback_data='Добавить рабочие часы')
        z.add(btn1488)
        bot.send_message(message.chat.id, 'Попробовать ещё раз', reply_markup=z)


@bot.callback_query_handler(func=lambda c: c.data in ['True', 'False'])
def adding(callback):
    gid_t[callback.message.chat.id][0] = Id_gid_by_name(gid_t[callback.message.chat.id][0])
    guides_sql(gid_t[callback.message.chat.id])
    bot.send_message(callback.message.chat.id,
                     'Рабочее время добавлено! Жми /start или на кнопки внизу,чтобы перейти к началу')


@bot.callback_query_handler(func=lambda c: c.data == "Удалить рабочие часы")
def guide_namer_3(callback):
    global gid_d
    gid_d = {}
    o = bot.send_message(callback.message.chat.id, "Введите имя гида")
    bot.register_next_step_handler(o, date_del)


def date_del(message):
    if message.text in name():
        gid_d.update({message.chat.id: [message.text]})
        h = bot.send_message(message.chat.id, "Введите дату, в которую вы хотите удалить часы")
        bot.register_next_step_handler(h, data_del2)
    else:
        button_mes(message,["Удалить рабочие часы"],"Такого гида нет")


def data_del2(message):
    message.text += ".2022"
    try:
        f = datetime.strptime(message.text, '%d.%m.%Y')
        gid_d[message.chat.id].append(f)
        bot.send_message(message.chat.id,
                         text=f"Подтвердите удаление:\n1)Гид: {gid_d[message.chat.id][0]}\n2)Дата: {gid_d[message.chat.id][1]}")
        confirm_keyboard = types.InlineKeyboardMarkup()
        True_ = types.InlineKeyboardButton(text="Удалить!", callback_data="delete_zap")
        False_ = types.InlineKeyboardButton(text="Неверно, попробовать ещё раз", callback_data="Удалить рабочие часы")
        confirm_keyboard.row(True_, False_)
        bot.send_message(message.chat.id, "Удалить эту запись?", reply_markup=confirm_keyboard)
    except ValueError:
        bot.send_message(chat_id=message.chat.id,
                         text="Я вас не понимаю:( Введите дату в формате дата.месяц, например, 31.05")
        z = types.InlineKeyboardMarkup()
        btn1488 = types.InlineKeyboardButton(text='Ещё раз', callback_data='Удалить рабочие часы')
        z.add(btn1488)
        bot.send_message(message.chat.id, 'Попробовать ещё раз', reply_markup=z)


@bot.callback_query_handler(func=lambda c: c.data == "delete_zap")
def delete_zap_(callback):
    gid_d[callback.message.chat.id][0] = Id_gid_by_name(gid_d[callback.message.chat.id][0])
    delete_workhours(gid_d[callback.message.chat.id][0], gid_d[callback.message.chat.id][1])
    bot.send_message(callback.message.chat.id,
                     'Запись успешно удалена!\nЖми /start или на кнопки внизу,чтобы перейти к началу')


@bot.callback_query_handler(func=lambda c: c.data == "Блок места для гида")
def guide_namer_4(callback):
    global gid_b
    gid_b = {}
    o = bot.send_message(callback.message.chat.id, "Введите имя гида")
    bot.register_next_step_handler(o, place)


def place(message):
    gid_b.update({message.chat.id: [message.text]})
    start_keyboard = types.ReplyKeyboardMarkup(row_width=1, resize_keyboard=True)
    for i in places.keys():
        start_keyboard.add(types.KeyboardButton(text=i))
    bot.send_message(message.chat.id, "Выбери категорию", reply_markup=start_keyboard)


@bot.message_handler(
    func=lambda m: m.text == "Крыши")
def exc_cur(message):
    gid_b[message.chat.id].append(message.text)
    global mes
    mes = message.text
    button_mes(message, places[message.text], f'{mes}')


@bot.callback_query_handler(func=lambda c: c.data in ["Индивидуальная", "Групповая"])
def excur_up(callback):
    gid_b[callback.message.chat.id].append(callback.data)

    button_call(callback, places[mes][callback.data], f'{callback.data} экскурсии')


@bot.message_handler(
    func=lambda m: m.text == "Парадные")
def ex_down(message):
    gid_b[message.chat.id].append(message.text)
    gid_b[message.chat.id].append('Индивидуальная')
    button_mes(message, places[message.text], 'Выбери экскурсию')


@bot.message_handler(
    func=lambda m: m.text == "Комбо")
def ex_down2(message):
    gid_b[message.chat.id].append(message.text)
    gid_b[message.chat.id].append('Индивидуальная')
    button_mes(message, places[message.text], 'Выбери экскурсию')


@bot.callback_query_handler(
    func=lambda c: c.data in ['Башенка', 'Мекс', 'Хогвартс', 'Политка', 'Фонтанка', 'Контрасты без крыши',
                              'Сердце Петербурга', 'Контрасты с крышей', 'Секреты Петроградки', 'Секреты лайт'])
def promowter_dates_kb(callback):
    gid_b[callback.message.chat.id].append(callback.data)
    bot.send_message(callback.message.chat.id,
                     text=f"Подтвердите блок:\n1)Гид: {gid_b[callback.message.chat.id][0]}\n2)Эксурсия: {gid_b[callback.message.chat.id][1]}, {gid_b[callback.message.chat.id][2]}, {gid_b[callback.message.chat.id][3]}")
    confirm_keyboard = types.InlineKeyboardMarkup()
    True_ = types.InlineKeyboardButton(text="Заблокировать!", callback_data="Заблокировать!")
    False_ = types.InlineKeyboardButton(text="Неверно, попробовать ещё раз", callback_data="Блок места для гида")
    confirm_keyboard.row(True_, False_)
    bot.send_message(callback.message.chat.id, "Заблокировать это место?", reply_markup=confirm_keyboard)


@bot.callback_query_handler(func=lambda c: c.data == 'Заблокировать!')
def block_p(callback):
    bot.send_message(callback.message.chat.id,
                     "Место заблокировано!\nЖми /start или на кнопки внизу,чтобы перейти к началу")
    block(gid_b[callback.message.chat.id][0], gid_b[callback.message.chat.id][1], gid_b[callback.message.chat.id][2],
          gid_b[callback.message.chat.id][3],callback)


@bot.callback_query_handler(func=lambda c: c.data in ["Время до точки","Неверно"])
def final(callback):
    global gid_a
    gid_a = {}
    o = bot.send_message(callback.message.chat.id, "Введите имя гида")
    bot.register_next_step_handler(o, placik)

def placik(message):
    gid_a.update({message.chat.id: [message.text]})
    com = bot.send_message(chat_id=message.chat.id,
                                text="Введите дату в формате дата. месяц")
    bot.register_next_step_handler(com, datini)

def datini(message):
    try:
        f = datetime.strptime(message.text + ".22", '%d.%m.%y')
        gid_a[message.chat.id].append(f)
        h = bot.send_message(message.chat.id, "Введите время до Петроградки в формате (часы:минуты),например,00:10")
        bot.register_next_step_handler(h, policas)
    except ValueError:
        bot.send_message(chat_id=message.chat.id,
                         text="Я вас не понимаю:( Введите время в формате часы:минуты, например, 10:00")
        z = types.InlineKeyboardMarkup()
        btn1488 = types.InlineKeyboardButton(text='Ещё раз', callback_data="Время до точки")
        z.add(btn1488)
        bot.send_message(message.chat.id, 'Попробовать ещё раз', reply_markup=z)


def policas(message):
    if len(message.text) == 4:
        message.text = '0' + message.text
    message.text = message.text + ':00'
    if re.match(r'[0-5]{1}[0-9]{1}:[0-5]{1}[0-9]{1}:[0-5]{1}[0-9]{1}', message.text):
        gid_a[message.chat.id].append(message.text)
        h = bot.send_message(message.chat.id, "Введите время до Политки в формате (часы:минуты),например,00:10")
        bot.register_next_step_handler(h, policas_q)
    else:
        bot.send_message(chat_id=message.chat.id,
                         text="Я вас не понимаю:( Введите время в формате часы:минуты, например, 10:00")
        z = types.InlineKeyboardMarkup()
        btn1488 = types.InlineKeyboardButton(text='Ещё раз', callback_data="Время до точки")
        z.add(btn1488)
        bot.send_message(message.chat.id, 'Попробовать ещё раз', reply_markup=z)

def policas_q(message):
    if len(message.text) == 4:
        message.text = '0' + message.text
    message.text = message.text + ':00'
    if re.match(r'[0-5]{1}[0-9]{1}:[0-5]{1}[0-9]{1}:[0-5]{1}[0-9]{1}', message.text):
        gid_a[message.chat.id].append(message.text)
        h = bot.send_message(message.chat.id, "Введите время до Хогвартса в формате (часы:минуты),например,00:10")
        bot.register_next_step_handler(h, policas_p)
    else:
        bot.send_message(chat_id=message.chat.id,
                         text="Я вас не понимаю:( Введите время в формате часы:минуты, например, 10:00")
        z = types.InlineKeyboardMarkup()
        btn1488 = types.InlineKeyboardButton(text='Ещё раз', callback_data="Время до точки")
        z.add(btn1488)
        bot.send_message(message.chat.id, 'Попробовать ещё раз', reply_markup=z)

def policas_p(message):
    if len(message.text) == 4:
        message.text = '0' + message.text
    message.text = message.text + ':00'
    if re.match(r'[0-5]{1}[0-9]{1}:[0-5]{1}[0-9]{1}:[0-5]{1}[0-9]{1}', message.text):
        gid_a[message.chat.id].append(message.text)
        h = bot.send_message(message.chat.id, "Введите время до Центра в формате (часы:минуты),например,00:10")
        bot.register_next_step_handler(h, pol)
    else:
        bot.send_message(chat_id=message.chat.id,
                         text="Я вас не понимаю:( Введите время в формате часы:минуты, например, 10:00")
        z = types.InlineKeyboardMarkup()
        btn1488 = types.InlineKeyboardButton(text='Ещё раз', callback_data="Время до точки")
        z.add(btn1488)
        bot.send_message(message.chat.id, 'Попробовать ещё раз', reply_markup=z)

def pol(message):
    if len(message.text) == 4:
        message.text = '0' + message.text
    message.text = message.text + ':00'
    if re.match(r'[0-5]{1}[0-9]{1}:[0-5]{1}[0-9]{1}:[0-5]{1}[0-9]{1}', message.text):
        gid_a[message.chat.id].append(message.text)
        button_mes(message,["Все верно","Неверно"],f"Имя гида:{gid_a[message.chat.id][0]}\nДата выхода на работу:{str(gid_a[message.chat.id][1])[0:10]}\n"
                                                     f"Введите время до Петроградки:{gid_a[message.chat.id][2][0:5]}\nВведите время до Политки:{gid_a[message.chat.id][3][0:5]}\n"
                                                     f"Введите время до Хогвартса:{gid_a[message.chat.id][4][0:5]}\nВведите время до Центра:{gid_a[message.chat.id][5][0:5]}\n"
                                                     )
    else:
        bot.send_message(chat_id=message.chat.id,
                         text="Я вас не понимаю:( Введите время в формате часы:минуты, например, 10:00")
        z = types.InlineKeyboardMarkup()
        btn1488 = types.InlineKeyboardButton(text='Ещё раз', callback_data="Время до точки")
        z.add(btn1488)
        bot.send_message(message.chat.id, 'Попробовать ещё раз', reply_markup=z)

@bot.callback_query_handler(func=lambda c: c.data in ["Все верно"])
def patyk(callback):
    timerlan(gid_a[callback.message.chat.id])
    bot.edit_message_text(chat_id=callback.message.chat.id, message_id=callback.message.id,
                          text="Жми /start или на кнопки внизу,чтобы перейти к началу")


bot.polling(none_stop=True, interval=0)

