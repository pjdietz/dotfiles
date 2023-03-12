function layout() {
    return {
        name: "Focus",
        extends: "fullscreen",
        getFrameAssignments: (windows, screenFrame, state, extendedFrames) => {
            const paddingTop = 50;
            const paddingRight = 450;
            const paddingLeft = 450;
            const paddingBottom = 100;
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
