# todoflutter

Todolist app with `Riverpod`

## Installation
You need to have `Flutter` set up in your environment.

First of all, this project needs to be cloned either by using `Git` or by downloading the ZIP and extracting it to your environment (Clone URL: https://github.com/Elyes3/todo-flutter.git).

Right after that, the dependencies of the project should be installed through the command:

```Flutter pub get```.

After that you need to run the project on the device of your choice:

```Flutter run```.

## Explanation

- This app makes use of `flutter_modular` package for routing/binding.

- The environment variables are pushed within this GitHub Repo (not a best practice) in order to make the setup of the project simpler.

- The todo consists of four fields. an `__id` generated by `MongoDB`, a `description` (`string`), `millis`(`int`) which references the day on which the todo should exist and a `completed` field (`boolean`) that tells whether the todo is done or still in progress.

- The app consists of 2 views :

    - A Home Page that contains a calendar from which you can select a day for which you want to check the todos.

    - A Todos Page in which you can list the todos for the selected day. You can also create, edit and delete todos. The app 
    also gives the possibility to modify the status of a specific todo (done,in_progress) and also filter todos depending on
    their status and all of that making use of the `Riverpod` reactive caching.

- The app uses the following architecture. Each part was abstracted in its own logic:

    ```View -> TodosNotifierProvider(riverpod_package) -> TodosService (asynchronous calls to the backend server)```

    Through an event called from the view, the UI calls the provider. The provider then calls the service in order to load the data from the server. A loading state is shown during the server call. If the call resolves successfully. The data is shown in the UI else a snackbar displays an error message. In order to show the data inside the UI, the reactivity system of riverpod is used. For that, I made use of the notifier to update the state reactively depending on the return value of the server call that was made.

-  In order to update a specific todo's description. You need to press on the todo. And the `description` of the todo will transform into a textfield. You can then edit it. When the textfield is out of focus. The `description` gets updated.

PS: Sometimes disabling the firewall for private networks is needed to make the destination reachable.