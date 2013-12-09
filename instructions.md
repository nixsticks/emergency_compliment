# Emergency Compliment

In this exercise you will create an application that will give your user a single well formatted compliment every time they refresh the page.

Examples:
- http://emergencycompliment.com/
- http://emergencycorgi.com/
- http://happyvday-mh.herokuapp.com/


## Instructions

1. Create a Sinatra application that has a single route `/compliments`.

2. Create a model, `compliment.rb` and put it in your `lib` folder. Every new object should have an instance variable, `message`, that contains a random compliment and an instance variable, `image`, that has a random cute or funny image. Feel free to make your emergency compliment page themed.

3. Create a single view, `compliment.erb`, and put it in your views folder. This view should be rendered when the user hits the `/compliments` route and should show the message and image of a Compliment object.

4. Create a `layout.erb` file and put it in your views folder. In this file you should scaffold a basic HTML5 page. Place `<%= yield %>` inside the `<body>` tag.

5. Create a `styles.css` file and put it in your public folder. Make sure this file is linked in your layout. Use this to apply some styles to your view.

** NOTE ** Try your best to keep all of your logic out of your views and inside your route in `app.rb` or your model.

## Extensions

- include twitter bootstrap and make your site responsive
- use a google font! or three.
- write logic that picks a random style (i.e. background color, text color, etc)
- write logic that prevents the same image or message from appearing twice in a row


## Challenge
- create a unique route for every compliment so that it can be linked back to individually later
(we'll be going over this tomorrow, but if you have the time, try it out!)