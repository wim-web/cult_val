```
cp elixir_metric.example.ini elixir_metric.ini
sudo ln -s $(pwd)/elixir_metric.ini /etc/systemd/system/elixir_metric.ini
sudo ln -s $(pwd)/elixir_metric.service /etc/systemd/system/elixir_metric.service
sudo ln -s $(pwd)/elixir_metric.timer /etc/systemd/system/elixir_metric.timer
```
