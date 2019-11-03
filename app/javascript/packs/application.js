require("@rails/ujs").start()
//require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
import 'jquery'
import 'bootstrap'
import { initAutocomplete } from '../plugins/init_autocomplete'
import { initCalendar } from '../plugins/init_flatpickr'
import { photoPreview } from '../dom/photo_uploader'

initAutocomplete()
initCalendar()
photoPreview()