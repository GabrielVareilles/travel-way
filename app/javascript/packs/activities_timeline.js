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
      <div data-yelp-id="${activity.yelp_id}">
        <a class="details-link" data-toggle="modal" data-target="#info-${activity.id}">View details</a>
      </div>
    </div>

 <!--  Modal -->
    <div class="modal fade" id="info-${activity.id}" tabindex="-1" role="dialog" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
         <button type="button" class="modal-close-btn" data-dismiss="modal" aria-label="Close"><span class="glyphicon glyphicon-remove"></span></button>
         <div class="modal-body container-fluid portfolio mobile">
            <!--  Carousel -->
            <div id="carousel-portfolio-2" class="carousel slide" data-ride="carousel">
              <div class="carousel-inner" role="listbox">
                <div class="item active">
                  <img src="${activity.image_url}" alt="" />
                </div>
              </div>
            </div>
            <div class="row">
              <div class="col-md-5">
                <div class="portfolio-title">
                  <div class="portfolio-icon">
                    <div>M</div>
                  </div>
                  <div class="title">
                    <h4>${activity.name}</h4>
                    <em>UI / UX design.</em>
                  </div>
                </div>
              </div>
              <div class="modal-text col-md-7">
                <p><ul id="${ activity.id }-reviews"> test texte reviews </ul></p>
              </div>
            </div>
          </div>
        </div>
      </div>
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
        let link = document.querySelectorAll(`#${city} .details-link`)[index]
        link.addEventListener("click", (event) => {
            const yelp_id = event.target.parentNode.dataset.yelpId;
            const reviews = fetchReviews(yelp_id);
            document.querySelector(".header-title").insertAdjacentHTML("beforeend", `${reviews}`)
        });
      }, 150 * index);
    });

    results.categories.forEach((category, index) => {
      setTimeout(() => {
        categoriesList.insertAdjacentHTML('beforeend', buttonTemplate(city, category));
      }, 150 * index)
    });

    // document.querySelectorAll(".details-link").forEach( (link) => {
    //   console.log(link);
    //   link.addEventListener("click", (event) => {
    //       const yelp_id = event.target.parentNode.dataset.yelpId;
    //       const reviews = fetchReviews(yelp_id);
    //       document.querySelector(".header-title").insertAdjacentHTML("beforeend", `${reviews}`)
    //   });
    // });
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
