#!/usr/bin/perl -w

use strict;

package MusicBrainz::Server::CollectionInfo;


sub new
{
	my ($this, $userId, $sql)=@_;
	
	my %collectionHash;
	my %artistHash;
	
	
	
	my $query="SELECT * FROM collection_info WHERE moderator='$userId'";
	my $result=$sql->SelectSingleRowHash($query);
	
	
	
	bless(
	{
		DBH				=> $sql,
		userId			=> $userId,
		result			=> $result,
		collectionId	=> $result->{id} #$result{id}
		#collectionHash	=> {}, # {'Smash Mouth' => ('Release 1', 'Release 2'), 'Fort Minor' => ('Release')}
		#artistHash		=> {}
	}, $this);
}



sub RetrieveCollection
{
	my($this)=@_;
	
	my %collection;
}


sub GetHasReleases
{
	my ($this)=@_;
	
	
	my $sql=$this->{DBH};
	
	#my $query="SELECT (album.name) FROM album INNER JOIN collection_info ON (collection_has_release_join.collection_info = album.id) INNER JOIN collection_info ON (collection_has_release_join.collection_info = collection_info.id)";
	
	#my $query="SELECT album.name FROM album INNER JOIN collection_has_release_join b ON b.album = album.id INNER JOIN collection_info ON c.id = b.collection_info";
	
	#my $query="SELECT artist,name,attributes,gid FROM album WHERE id IN (SELECT album FROM collection_has_release_join WHERE collection_info='123')";
	
	my $query="SELECT album.artist AS artistid, album.name AS albumname, album.attributes, album.gid, artist.name AS artistname FROM album, artist WHERE album.id IN (SELECT album FROM collection_has_release_join WHERE collection_info='123') AND artist.id=album.artist";
	
	my $result=$sql->SelectListOfHashes($query);
	
	return $result;
}


sub GetHasMBIDs
{
	my ($this)=@_;
	
	my $sql=$this->{DBH};
	
	my $query="SELECT album.gid FROM album WHERE album.id IN (SELECT album FROM collection_has_release_join WHERE collection_info='123')"; # order by some stuff here
	
	my $result=$sql->SelectListOfLists($query);
	
	return $result;
}



sub GetHasArtists
{
	my ($this)=@_;
	
	my $sql=$this->{DBH};
	
	my $query="SELECT id,name FROM artist WHERE id IN (SELECT artist FROM album WHERE id IN (SELECT album FROM collection_has_release_join WHERE collection_info='123'))";
	
	my $result=$sql->SelectListOfHashes($query);
	
	
	use Data::Dumper;
	print Dumper($result);
}



sub GetMissingReleases
{
	my ($this)=@_;
	
	my $sql=$this->{DBH};
	
	#my $query="SELECT * FROM album WHERE artist IN (SELECT artist FROM collection_discography_artist_join WHERE collection_info='123')";
	
	my $query="SELECT album.name AS albumname, album.attributes, album.gid AS mbid, album.artist AS artistid,artist.name AS artistname FROM album,artist WHERE album.artist IN (SELECT artist FROM collection_discography_artist_join WHERE collection_info='123') AND artist.id IN (SELECT artist FROM collection_discography_artist_join WHERE collection_info='123')";
	
	my $result=$sql->SelectListOfHashes($query);
	
	use Data::Dumper;
	print Dumper($result);
}



1;