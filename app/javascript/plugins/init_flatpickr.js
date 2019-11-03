const flatpickr = require("flatpickr");
import { Italian } from "flatpickr/dist/l10n/it.js"


const initCalendar = () => {
  flatpickr(`#race_date`, {
    dateFormat: "d-m-Y",
    "locale": Italian,
     minDate: "today"
  });
  
  flatpickr(`#race_departure_time`, {
    enableTime: true,
    noCalendar: true,
    dateFormat: "H:i",
    time_24hr: true,
    "locale": Italian
  }
  )

  flatpickr(`#race_price_start_date`, {
    mode: "range",
    "locale": Italian,

  }
  )
  
}

export { initCalendar }  