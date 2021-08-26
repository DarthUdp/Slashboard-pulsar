import React from 'react';

interface LogsProps {
}

interface LogsState {
}

class Logs extends React.Component<LogsProps, LogsState> {
    constructor(props: LogsProps) {
        super(props);
    }

    render() {
        return (
            <div className="body-wrapper">
                <div className="body-panel-wrapper">
                    This is the Logs control panel. Although the component exists,&nbsp;
                    you should NOT be able to access it. Please file an issue in&nbsp;
                    <a href="https://github.com/l3alr0g/Slashboard/issues" target="_blank">
                        the project's issue section&nbsp;
                    </a>
                    to report this bug
                </div>
            </div>
        );
    }
}

export default Logs;