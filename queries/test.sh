#!/bin/bash

# athugar hvort .sql skrain se nyrri en gagnagrunnurinn og recompilar ef svo er
[ ../profSchema.sql -nt ./profSchema.db ] && $(echo '.save profSchema.db' | sqlite3 -init ../profSchema.sql) && echo 'Recompiled'

sqlite3 profSchema.db '.read tumi-2021.sql'
