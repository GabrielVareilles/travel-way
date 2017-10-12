function cardTemplate (activity) {
  return `
    <div class="col-md-4 col-sm-6 portfolio panel all ${activity.category} animated fadeIn">
      <div class="card-setactivity">
        <div class="panel-body">
          <div class="portfolio-title">
            <div class="portfolio-icon">
              <div><input type="checkbox" name="trip[activity_ids][]" value="${activity.id}"></div>
            </div>
            <div class="title">
              <h4>${activity.name}</h4>
              <em>Homepage redesign for a well known brand.</em>
            </div>
          </div>
        </div>
        <div class="activities-portfolio-image" style="background-image: linear-gradient(rgba(0,0,0,0.3), rgba(0,0,0,0.2)), url('${activity.image_url}');">
        </div>
      </div>
      <a class="" data-toggle="modal" data-target="#info-${activity.id}">View details</a>
    </div>
  `
}

function buttonTemplate(city, category) {
  return `
    <button type="button" class="allFilter btn background-black filter-selected animated fadeInDown" onclick="filterCategories('${city}', '${category}')">${category}</button>
  `
}

function fetchActivitiesForPlace (city, callback) {
  const timeline = document.getElementById('timeline');
  const list = timeline.querySelector(`#${city} .activities-list`);
  const categoriesList = timeline.querySelector(`#${city} .categories-list .portfolio-filters`);

  fetch(`/search?place=${city}`, { credentials: "same-origin" })
  .then(response => response.json())
  .then(results => {
    list.innerHTML = '';
    results.activities.forEach((activity, index) => {
      setTimeout(() => {
        list.insertAdjacentHTML('beforeend', cardTemplate(activity));
      }, 150 * index)
    });

    results.categories.forEach((category, index) => {
      setTimeout(() => {
        categoriesList.insertAdjacentHTML('beforeend', buttonTemplate(city, category));
      }, 150 * index)
    });
  })
}

$(() => {
  const timeline = document.getElementById('timeline');
  if (timeline) {
    JSON.parse(timeline.dataset.places).forEach((place) => {
      fetchActivitiesForPlace(place);
    })
  }
})
