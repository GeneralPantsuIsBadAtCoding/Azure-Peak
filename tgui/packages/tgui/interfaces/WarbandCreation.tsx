import { useState } from 'react';
import { Button, Stack } from 'tgui-core/components';

import { Window } from '../layouts';
import { useWarbandData } from './warband/WarbandData';
import { useWarbandFilters } from './warband/WarbandFilters';
import { useWarbandSelection } from './warband/WarbandSelection';
import { ClassesTab } from './warband/WarbandTabClasses';
import { CreationTab } from './warband/WarbandTabCreation';
import { FinalizeTab } from './warband/WarbandTabFinalize';
import { WorldTab } from './warband/WarbandTabWorld';

export const WarbandCreation = () => {
  const { user_role, act, warbandList, subtypeList, aspectList, classList, storytellersList, nobleList, alliesList } = useWarbandData();
  const {
    selectedWarband,
    selectedSubtype,
    selectedAspects,
    selectedClass,
    selectedSubclass,
    pointCounter,
    handleWarbandSelect,
    handleSubtypeSelect,
    handleAspectSelect,
    handleClassSelect,
    handleSubclassSelect,
  } = useWarbandSelection();
  
  const { filteredWarbands, filteredSubtypes, filteredAspects, availableClasses, filteredGruntClasses } = useWarbandFilters(
    user_role,
    selectedWarband,
    selectedSubtype,
    warbandList,
    subtypeList,
    aspectList,
    classList,
    storytellersList
  );

  const [activeTab, setActiveTab] = useState('creation');

  const finalize_disabled =
    pointCounter < 0 ||
    !selectedWarband ||
    !selectedClass ||
    (selectedWarband?.subtyperequired && !selectedSubtype) ||
    (selectedWarband?.title === "MERCENARY COMPANY" && !selectedSubclass);

  const pointsColor = pointCounter > 0 ? '#2ee62eff' : (pointCounter < 0 ? '#FF0000' : '#4b504bff');

  return (
    <Window theme="azure_default" width={1000} height={700}>
      <Window.Content>
        <Stack style={{ borderBottom: '2px solid #7b5353' }}>
          <Button onClick={() => setActiveTab('creation')} disabled={activeTab === 'creation'}>CREATE WARBAND</Button>
          <Button onClick={() => setActiveTab('classes')} disabled={activeTab === 'classes'}>CREATE CHARACTER</Button>
          <Button onClick={() => setActiveTab('world')} disabled={activeTab === 'world'}>BEHOLD AZURIA</Button>
          <Button onClick={() => setActiveTab('goforth')} disabled={activeTab === 'goforth'}>GO FORTH</Button>
          <span style={{
            height: '40px',
            alignItems: 'flex-end',
            paddingBottom: '5px',
          }}>
            AVAILABLE ASPECT POINTS: <span style={{ color: pointsColor }}>{pointCounter}</span>
          </span>
        </Stack>

        {activeTab === 'creation' && (
          <CreationTab
            filteredWarbands={filteredWarbands}
            filteredSubtypes={filteredSubtypes}
            filteredAspects={filteredAspects}
            selectedWarband={selectedWarband}
            selectedSubtype={selectedSubtype}
            selectedAspects={selectedAspects}
            handleWarbandSelect={handleWarbandSelect}
            handleSubtypeSelect={handleSubtypeSelect}
            handleAspectSelect={handleAspectSelect}
            act={act}
          />
        )}
        {activeTab === 'classes' && (
          <ClassesTab
            selectedWarband={selectedWarband}
            selectedClass={selectedClass}
            selectedSubclass={selectedSubclass}
            availableClasses={availableClasses}
            filteredGruntClasses={filteredGruntClasses}
            handleClassSelect={handleClassSelect}
            handleSubclassSelect={handleSubclassSelect}
            act={act}
          />
        )}
        {activeTab === 'world' && (
          <WorldTab
            nobleList={nobleList}
            alliesList={alliesList}
            act={act}
          />
        )}
        {activeTab === 'goforth' && (
          <FinalizeTab
            user_role={user_role}
            selectedWarband={selectedWarband}
            selectedSubtype={selectedSubtype}
            selectedAspects={selectedAspects}
            selectedClass={selectedClass}
            selectedSubclass={selectedSubclass}
            finalize_disabled={finalize_disabled}
            pointCounter={pointCounter}
            act={act}
          />
        )}
      </Window.Content>
    </Window>
  );
};

