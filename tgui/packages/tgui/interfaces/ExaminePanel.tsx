import { useState } from 'react';
import { Button, Stack } from 'tgui-core/components';

import { useBackend } from '../backend';
import { PageButton } from '../components/PageButton';
import { Window } from '../layouts';
import { ExaminePanelData } from './ExaminePanelData';
import { FlavorTextPage } from './ExaminePanelPages';
import { ImageGalleryPage } from './ExaminePanelPages';
import { NSFWHeadshotPage } from './ExaminePanelPages';

enum Page {
  FlavorText,
  ImageGallery,
  NSFWHeadshot,
}

export const ExaminePanel = (props) => {
  const { act, data } = useBackend<ExaminePanelData>();
  const { is_vet, character_name, is_playing, has_song, img_gallery, is_naked, nsfw_headshot } = data;
  const [currentPage, setCurrentPage] = useState(Page.FlavorText);

  let pageContents;

  switch (currentPage) {
    case Page.FlavorText:
      pageContents = <FlavorTextPage />;
      break;
    case Page.ImageGallery:
      pageContents = <ImageGalleryPage />;
      break;
	case Page.NSFWHeadshot:
      pageContents = <NSFWHeadshotPage />;
      break;
  }

  return (
    <Window title={character_name} width={1000} height={700} buttons={
      <>
      {!!is_vet && (
        <Button
          color="gold"
          icon="crown"
          tooltip="This player is age-verified!"
          tooltipPosition="bottom-start"
          onClick={() => act('vet_chat')}
        />
      )}
      <Button
      color="green"
      icon="music"
      tooltip="Music player"
      tooltipPosition="bottom-start"
      onClick={() => act('toggle')}
      disabled={!has_song}
      selected={!is_playing}
      />
      </>}>
      <Window.Content>
        <Stack vertical fill>
          {((img_gallery.length > 0 && !is_naked) || (img_gallery.length > 0 && is_naked && !nsfw_headshot)) && (
          <Stack>
            <Stack.Item grow>
              <PageButton
              currentPage={currentPage}
              page={Page.FlavorText}
              setPage={setCurrentPage}
              >
                Flavor Text
              </PageButton>
            </Stack.Item>
            <Stack.Item grow>
              <PageButton
              currentPage={currentPage}
              page={Page.ImageGallery}
              setPage={setCurrentPage}
              >
                Image Gallery
              </PageButton>
            </Stack.Item>
          </Stack>
          )}
		  {(!(img_gallery.length > 0) && is_naked && nsfw_headshot) && (
          <Stack>
            <Stack.Item grow>
              <PageButton
              currentPage={currentPage}
              page={Page.FlavorText}
              setPage={setCurrentPage}
              >
                Flavor Text
              </PageButton>
            </Stack.Item>
            <Stack.Item grow>
              <PageButton
              currentPage={currentPage}
              page={Page.NSFWHeadshot}
              setPage={setCurrentPage}
              >
                Nudeshot
              </PageButton>
            </Stack.Item>
          </Stack>
          )}
		  {(img_gallery.length > 0 && is_naked && nsfw_headshot) && (
          <Stack>
            <Stack.Item grow>
              <PageButton
              currentPage={currentPage}
              page={Page.FlavorText}
              setPage={setCurrentPage}
              >
                Flavor Text
              </PageButton>
            </Stack.Item>
			<Stack.Item grow>
              <PageButton
              currentPage={currentPage}
              page={Page.ImageGallery}
              setPage={setCurrentPage}
              >
                Image Gallery
              </PageButton>
            </Stack.Item>
            <Stack.Item grow>
              <PageButton
              currentPage={currentPage}
              page={Page.NSFWHeadshot}
              setPage={setCurrentPage}
              >
                Nudeshot
              </PageButton>
            </Stack.Item>
          </Stack>
          )}
          {(img_gallery.length > 0 || (is_naked && nsfw_headshot)) && (<Stack.Divider />)}
          <Stack.Item grow position="relative" overflowX="hidden" overflowY="auto">
            {pageContents}
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};
