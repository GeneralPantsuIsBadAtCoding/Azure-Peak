import { useState } from 'react';
import { Stack } from 'tgui-core/components';
import { PageButton } from '../components/PageButton';
import { FlavorTextPage } from './ExaminePanelPages';
import { ImageGalleryPage } from './ExaminePanelPages';
import { Window } from '../layouts';
import { useBackend } from '../backend';
import { ExaminePanelData } from './ExaminePanelData';

enum Page {
  FlavorText,
  ImageGallery,
}

export const ExaminePanel = (props) => {
  const { data } = useBackend<ExaminePanelData>();
  const { character_name } = data;
  const [currentPage, setCurrentPage] = useState(Page.FlavorText);

  let pageContents;

  switch (currentPage) {
    case Page.FlavorText:
      pageContents = <FlavorTextPage />;
      break;
    case Page.ImageGallery:
      pageContents = <ImageGalleryPage />;
      break;
  }

  return (
    <Window title={character_name} width={1000} height={700}>
      <Window.Content>
        <Stack vertical fill>
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
          <Stack.Divider />
          <Stack.Item grow position="relative" overflowX="hidden" overflowY="auto">
            {pageContents}
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};
