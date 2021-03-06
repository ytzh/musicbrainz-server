/*
   This file is part of MusicBrainz, the open internet music database.
   Copyright (c) 2005 Stefan Kestenholz (keschte)
   Copyright (C) 2010 MetaBrainz Foundation

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

*/

MB.GuessCase = MB.GuessCase ? MB.GuessCase : {};

MB.GuessCase._Release = function () {
    var self = MB.Object ();

    self.gc = MB.GuessCase.Main ();
    self.guess = self.gc.guessRelease;

    return self;
};

$('document').ready (function () {

    MB.GuessCase.release = MB.GuessCase._Release ();
    MB.GuessCase["release_group"] = MB.GuessCase.release;
    MB.GuessCase["release-group"] = MB.GuessCase.release;

});
