import $ from "jquery";
import "bootstrap/dist/js/bootstrap";
export function flash_info() {
  $(document).on("turbolinks:load", function () {
    $("body").tooltip({
      selector: '[data-toggle="tooltip"]',
      container: "body",
    });
    $("body").popover({
      selector: '[data-toggle="popover"]',
      container: "body",
      html: true,
      trigger: "hover",
    });
  });
  $(document).on("turbolinks:load", function () {
    $(".alert")
      .delay(2000)
      .slideUp(500, function () {
        $(".alert").alert("close");
      });
  });


}
