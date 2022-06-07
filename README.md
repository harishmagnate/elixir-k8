# MyApp

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `my_app` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:my_app, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/my_app](https://hexdocs.pm/my_app).


ERLANG_COOKIE=$(head -c 40 < /dev/random | base64 | tr '/+' '_-')

kubectl --namespace default create secret generic my-elixir-app-cluster --from-literal=cookie="$ERLANG_COOKIE"
kubectl delete pods -l app=my-app -n default
kubectl describe pod my-elixir-app-k8-5987c56cbc-24znr

https://david-delassus.medium.com/elixir-and-kubernetes-a-love-story-721cc6a5c7d5