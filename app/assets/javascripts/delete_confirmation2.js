document.addEventListener('DOMContentLoaded', function() {
  const deleteLinks = document.querySelectorAll('a[data-confirm]');

  deleteLinks.forEach(function(link) {
    link.addEventListener('click', function(event) {
      if (!isMobileDevice() || window.confirm(this.dataset.confirm)) {
        event.preventDefault();
        window.location.href = this.href;
      }
    });
  });

  function isMobileDevice() {
    return /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent);
  }
});
