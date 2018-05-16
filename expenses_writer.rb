# encoding: utf-8

require 'rexml/document'
require 'date'

puts 'Что куплено?'
expense_text = STDIN.gets.chomp

puts 'Сколько потрачено?'
expense_amount = STDIN.gets.chomp.to_i

puts 'Когда потрачено? (дата в формате ДД.ММ.ГГГГ, пустое поле – сегодня)'
date_input = STDIN.gets.chomp

expense_date = nil

if date_input == ''
  expense_date = Date.today
else
  expense_date = Date.parse(date_input)
end

puts 'В какую категорию занести трату?'
expense_category = STDIN.gets.chomp

current_path = File.dirname(__FILE__)
file_name = current_path + '/my_expenses.xml'

f = File.new(file_name, 'r:UTF-8')
doc = REXML::Document.new(f)
f.close

expenses = doc.elements.find('expenses').first
expense = expenses.add_element 'expense', {
                         'amount' => expense_amount,
                         'category' => expense_category,
                         'date' => expense_date.to_s
                              }

expense.text = expense_text

f = File.new(file_name, 'w:UTF-8')
doc.write(f, 2)
f.close

puts 'Запись сохранена!'

