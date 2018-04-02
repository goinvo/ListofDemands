$(function() {
  $(document).on('turbolinks:load', function() {
    var $searchInput = $('input.search-input');

    $searchInput.bind("change keyup input paste", function(e) {
      var searchValue = e.target.value;
      var $demands = $(".demands-list li");
      $demands.each(function(i, demand) {
        var demandNameText = $(demand).find('.demand-name').text().toLowerCase();
        var demandMatchesSearchCriteria = demandNameText.includes(searchValue.toLowerCase());

        demandMatchesSearchCriteria ? $(demand).show() : $(demand).hide()
      });

      var visibleDemands = $demands.filter(":visible");
      visibleDemands.length === 0 ? $(".no-demands").show() : $(".no-demands").hide();
    });
  });
});
