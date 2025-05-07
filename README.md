# docker py3dtiles

**Note:** Py3dtiles now has an [official docker image](https://hub.docker.com/r/py3dtiles/py3dtiles).

[py3dtiles](https://gitlab.com/Oslandia/py3dtiles) installed docker image.

Also you can use [pdal](https://pdal.io/).

## py3dtiles usage

```sh
docker run --rm -v $(pwd):/data -it ha4db/py3dtiles py3dtiles convert /data/30XXX03010001-1.las --out /data/output
```
