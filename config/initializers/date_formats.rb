Time::DATE_FORMATS[:default] = ->(date) { date.strftime("%A, %B #{date.day.ordinalize}, %Y at %l:%M%p") }
