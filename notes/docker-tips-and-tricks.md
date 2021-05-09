# Docker Tips and Tricks

## Tag requirements

Per [Docker Tag command reference](https://docs.docker.com/engine/reference/commandline/tag/):

> A tag name must be valid ASCII and may contain lowercase and uppercase letters, digits, underscores, periods and dashes. A tag name may not start with a period or a dash and may contain a maximum of 128 characters.


## Annotations/Labels

[Use the OCI Annotations reference](https://github.com/opencontainers/image-spec/blob/master/annotations.md#annotations)

[Permanent Link](https://github.com/opencontainers/image-spec/blob/bd4f8fcb0979a663d8b97a1d4d9b030b3d2ca1fa/annotations.md)

This used to be called "Label Schema" but changed with the formation of OCI.

## OCI Annotations License

Source:
References:
<https://spdx.github.io/spdx-spec/3-package-information/#3.15>
<https://github.com/composer/composer/issues/2152>

Use `NONE`

It's a valid SPDX expression and it's way less ambiguous than `NOASSERTION`.

Note that `NOASSERTION` is _probably_ the correct thing to do, but it's still unclear whether `NOASSERTION` or `NONE` are more correctly meaning "proprietary", "closed source", and "all rights reserved". `NONE` reads as "no license granted", which is sort of clear. `NOASSERTION` reads as "no license found? No known license? None granted?".
