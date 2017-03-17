# Concurrency

Repository used during [this presentation about `processes`](https://slides.com/kevindisneur/processes).
The aim was to demystify GenServer.

## Steps

### Step 1

```
git checkout 802f7aa
```

We just have a [simple helper module](https://github.com/kdisneur/processes/blob/802f7aa/lib/todolist.ex).
We are just going to create a simple TODO list process. We should be able to:

* create a TODO list;
* add new items;
* remove an item;
* mark an item as done;
* get the items;

### Step 2

```
git checkout 9f788ca
```

[Simple implementation](https://github.com/kdisneur/processes/blob/9f788ca/lib/todolist/process.ex) using only what
we've seen in the slides. We can also have a look to
[the test](https://github.com/kdisneur/processes/blob/9f788ca/test/todolist/process_test.exs) to know how to use
this TODO list server.

### Step 3

```
git checkout 0e32b1f
```

[Update the current implementation](https://github.com/kdisneur/processes/blob/0e32b1f/lib/todolist/process.ex) to
have a clean separation between the interface and the implementation. We can have a look to
[the test](https://github.com/kdisneur/processes/blob/0e32b1f/test/todolist/process_test.exs) to see how easier to use
it became.

### Step 6

```
git checkout 78e87e7
```

Separate the [generic part of our code in a module](https://github.com/kdisneur/processes/blob/78e87e7/lib/mygenserver.ex)
and keep the specific part in [the current module](https://github.com/kdisneur/processes/blob/78e87e7/lib/todolist/mygenserver.ex)

### Step 7

```
git checkout 0778340
```

We can now compare how we would implement our TODO list using the
[real GenServer behaviour](https://github.com/kdisneur/processes/blob/0778340/lib/todolist/genserver.ex).

As we can see they look very similar. Of course, our implementation is very naive and we should always use the
real GenServer implementation but, at least, we now understand what happens underneath.
