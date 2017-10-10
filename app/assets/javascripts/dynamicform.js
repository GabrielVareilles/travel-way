$(document).on('turbolinks:load', function() {
  var city_counter = 1;

  var button = document.getElementById("button");

  button.addEventListener("click", (event) => {
    // console.log(button);
    var form = document.getElementById('forminputs');
    // console.log(form);
    city_counter = city_counter + 1;
    // console.log(`${city_counter + 1}`);
    form.insertAdjacentHTML('beforeend', `<div class='form-group text optional trip_places'><label class='control-label text optional', for='trip_places'>City ${city_counter}</label><input class='form-control string optional', placeholder='Where?', type='text', name='trip[places][]', id='trip_'></div>`
     );
  })
})

