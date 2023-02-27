function layout() {
    return {
        name: "Focus",
        extends: "fullscreen",
        getFrameAssignments: (windows, screenFrame, state, extendedFrames) => {
            const paddingTop = 0;
            const paddingRight = 400;
            const paddingLeft = 400;
            const paddingBottom = 60;
            return extendedFrames.reduce((frames, extendedFrame) => {
                const frame = {
                    x: extendedFrame.frame.x + paddingLeft,
                    y: extendedFrame.frame.y + paddingTop,
                    width: extendedFrame.frame.width - paddingLeft - paddingRight,
                    height: extendedFrame.frame.height - paddingTop - paddingBottom
                };
                return { ...frames, [extendedFrame.id]: frame };
            }, {});
        }
    };
}
