import { Button, Section, Stack } from 'tgui-core/components';

import { AspectType, SubType, WarbandType } from './WarbandTypes';

type CreationTabProps = {
  filteredWarbands: WarbandType[];
  filteredSubtypes: SubType[];
  filteredAspects: AspectType[];
  selectedWarband: WarbandType | null;
  selectedSubtype: SubType | null;
  selectedAspects: AspectType[];
  handleWarbandSelect: (warband: WarbandType) => void;
  handleSubtypeSelect: (subtype: SubType) => void;
  handleAspectSelect: (aspect: AspectType) => void;
  act: (action: string) => void;
};


export const CreationTab = ({
  filteredWarbands,
  filteredSubtypes,
  filteredAspects,
  selectedWarband,
  selectedSubtype,
  selectedAspects,
  handleWarbandSelect,
  handleSubtypeSelect,
  handleAspectSelect,
  act,
}: CreationTabProps) => {

  const getAspectColor = (points: number) => {
    if (points < 0) {
      return '#3c0d0d';
    } else if (points > 0) {
      return '#0f0606ff'; 
    }
    return undefined; 
  };


  return (
    <Stack vertical fill>
      <Stack row-Reverse style={{ flex: 1 }}>
        <Section title={<span style={{ color: '#7a2525ff' }}>AVAILABLE WARBANDS</span>} scrollable fill style={{ flex: 1, minWidth: '100px' }}>
          {filteredWarbands.length > 0 ? (
            <Stack vertical>
              {filteredWarbands.map((warband) => (
                <Button
                  key={warband.title}
                  onClick={() => {
                    act('interaction_sound');
                    handleWarbandSelect(warband);
                  }}
                  disabled={selectedWarband?.title === warband.title}
                  style={{ backgroundColor: selectedWarband?.title === warband.title ? '#7a2525ff' : undefined }}
                >
                  {warband.title}
                </Button>
              ))}
            </Stack>
          ) : (
            <div style={{ display: 'flex', justifyContent: 'center', alignItems: 'center', height: '100%' }}>
              <p>NO WARBANDS AVAILABLE.</p>
            </div>
          )}
        </Section>
        <Section title={<span style={{ color: '#7a2525ff' }}>SUBTYPE</span>} scrollable fill style={{ flex: 1, minWidth: '300px' }}>
          {selectedWarband && filteredSubtypes.length > 0 ? (
            <Stack vertical>
              {filteredSubtypes.map((subtype) => (
                <Button
                  key={subtype.title}
                  onClick={() => {
                    handleSubtypeSelect(subtype);                    
                    act('interaction_sound');
                  }}
                  tooltip={subtype.summary}
                  style={{ backgroundColor: selectedSubtype?.type === subtype.type ? '#7a2525ff' : undefined }}
                >
                  {subtype.title}
                </Button>
              ))}
            </Stack>
          ) : (
            <div style={{ display: 'flex', justifyContent: 'center', alignItems: 'center', height: '100%' }}>
              <p style={{ color: '#7a2525ff' }}>{selectedWarband ? 'NO SUBTYPES AVAILABLE' : 'SELECT A WARBAND'}</p>
            </div>
          )}
        </Section>
        <Section title={<span style={{ color: '#7a2525ff' }}>ASPECTS</span>} scrollable fill style={{ flex: 1, minWidth: '300px' }}>
          {selectedWarband && filteredAspects.length > 0 ? (
            <Stack vertical>
              {filteredAspects.map((aspect) => {
                const isSelected = selectedAspects.some((selected) => selected.title === aspect.title);
                return (
                  <Button
                    key={aspect.title}
                    onClick={() => {
                      handleAspectSelect(aspect);                      
                      act('interaction_sound');
                    }}
                    style={{ backgroundColor: isSelected ? '#7a2525ff' : getAspectColor(aspect.points), height: 'auto', padding: '12px 16px', whiteSpace: 'normal', textAlign: 'left' }}>
                    <div style={{ fontWeight: 'bold' }}>{aspect.title}</div>
                    <p style={{ margin: 0, fontSize: '15px' }}>{aspect.summary}</p>
                  </Button>
                );
              })}
            </Stack>
          ) : (
            <div style={{ display: 'flex', justifyContent: 'center', alignItems: 'center', height: '100%' }}>
              <p style={{ color: '#7a2525ff' }}>{selectedWarband ? 'NO ASPECTS AVAILABLE' : 'SELECT A WARBAND'}</p>
            </div>
          )}
        </Section>
      </Stack>
      <Section title={<span style={{ color: '#7a2525ff' }}>{selectedWarband?.title || 'No Warband Selected'}</span>} style={{ flex: 1 }}>
        {selectedWarband ? (
          <Stack vertical style={{ display: 'flex', flexDirection: 'column', textAlign: 'center' }}>
            <p>{selectedWarband.summary}</p>
            <p style={{ color: '#7a2525ff', marginBottom: '0' }}><i>{selectedSubtype?.quote}</i></p>
            <p style={{ color: '#582424ff', marginTop: '0' }}><b>{selectedSubtype?.quote_followup}</b></p>
          </Stack>
        ) : (
          <div style={{ display: 'flex', justifyContent: 'center', alignItems: 'center', height: '100%' }}>
            <p style={{ color: '#7a2525ff' }}>SELECT A WARBAND</p>
          </div>
        )}
      </Section>
    </Stack>
  );
};
