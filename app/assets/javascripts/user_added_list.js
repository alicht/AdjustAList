$(document).on('page:change', function(){
  var maxUsers      = 100, //maximum shifts allowed
      usersWrapper  = $('#users-wrapper'), //id tag where shifts elements will be inserted
      addUser      = $('#add-user');

  addUser.on('click', function(event){
    event.preventDefault();
    console.log("fired");
    appendUser();
  });

});

function appendUser(){
  try {
    $('.user-form.hidden').clone().removeClass('hidden').appendTo(usersWrapper);
  } catch(e) {
    console.log("Error: " + e.description);
  }
};