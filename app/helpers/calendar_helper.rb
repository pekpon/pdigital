module CalendarHelper
  def month_link(month_date)
    link_to(I18n.localize(month_date, :format => "%B"), {:month => month_date.month, :year => month_date.year})
  end
  
  # custom options for this calendar
    def event_calendar_opts
      { 
        :year => @year,
        :month => @month,
        :abbrev => false,
        :event_strips => @event_strips,
        :month_name_text => I18n.localize(@shown_month, :format => "%B"),
        :previous_month_text => "<< " + month_link(@shown_month.prev_month),
        :first_day_of_week => @first_day_of_week,
        :next_month_text => month_link(@shown_month.next_month) + " >>"    }
    end

    def event_calendar
      # args is an argument hash containing :event, :day, and :options
      calendar event_calendar_opts do |args|
        event = args[:event]
        %(<a href="#{event_path(event.slug)}" rel="popover" data-placement="top" data-content="#{h(event.short_description)}" data-original-title="#{h(event.name)}">#{h(event.name)}</a>)
      end
    end
  end