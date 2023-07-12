document.addEventListener('DOMContentLoaded', function() {
  const deleteLinks = document.querySelectorAll('.delete-link');

  deleteLinks.forEach(function(link) {
    link.addEventListener('click', function(event) {
      event.preventDefault();

      if (window.confirm('CUIDADO! Tem certeza que deseja apagar este registro do banco de dados? Ação sem retorno!')) {
        window.location.href = this.href;
      }
    });
  });
});
